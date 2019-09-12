require 'omniauth-oauth2'
require 'json'

module OmniAuth
  module Strategies
    class Zalo < OmniAuth::Strategies::OAuth2
      option :name, 'zalo'

      option :client_options, {
        site: 'https://oauth.zaloapp.com',
        authorize_url: '/v3/auth',
        token_url: '/v3/access_token',
        token_method: :get,
      }

      option :provider_ignores_state, true

      uid { raw_info['id'] }

      info do
        {
          name:  raw_info['name'],
          image: raw_info['picture']['data']['url'],
        }
      end

      def authorize_params
        super.merge(app_id: self.options.client_id)
      end

      def build_access_token
        token_url_params = {app_id: options.client_id, app_secret: options.client_secret, code: request.params['code'], redirect_uri: callback_url}.merge(token_params.to_hash(:symbolize_keys => true))
        parsed_response = client.request(options.client_options.token_method, client.token_url(token_url_params), parse: :json).parsed
        hash = {
          :access_token => parsed_response["access_token"],
          :expires_in => parsed_response["expires_in"],
        }
        ::OAuth2::AccessToken.from_hash(client, hash)
      end

      alias :old_callback_url :callback_url

      def callback_url
        if request.params['callback_url']
          request.params['callback_url']
        else
          old_callback_url
        end
      end

      def raw_info
        @raw_info ||= JSON.load(access_token.get("https://graph.zalo.me/v2.0/me?access_token=#{access_token.token}&fields=id,birthday,name,gender,picture,phone").body)
      rescue ::Errno::ETIMEDOUT
        raise ::Timeout::Error
      end
    end
  end
end

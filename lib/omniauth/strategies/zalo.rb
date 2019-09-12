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
        token_method: :get
      }

      uid { raw_info['userId'] }

      info do
        {
          name:        raw_info['displayName'],
          image:       raw_info['pictureUrl'],
          description: raw_info['statusMessage']
        }
      end

      def authorize_params
        super.merge(app_id: self.options.client_id)
      end

      alias :old_callback_url :callback_url

      def callback_url
        if request.params['callback_url']
          request.params['callback_url']
        else
          old_callback_url
        end
      end

      def callback_path
        params = session['omniauth.params']

        if params.nil? || params['callback_url'].nil?
          super
        else
          URI(params['callback_url']).path
        end
      end

      def raw_info
        @raw_info ||= JSON.load(access_token.get('https://graph.zalo.me/v2.0/me').body)
      rescue ::Errno::ETIMEDOUT
        raise ::Timeout::Error
      end
    end
  end
end

require 'omniauth-oauth2'
require 'json'

module OmniAuth
  module Strategies
    class Zalo < OmniAuth::Strategies::OAuth2
      include BuildAccessToken

      option :name, 'zalo'

      option :client_options, {
        site: 'https://oauth.zaloapp.com',
        authorize_url: '/v4/permission',
        token_url: '/v4/access_token',
        token_method: :post,
        grant_type: 'authorization_code',
        code_challenge: 'is5SvnFPQzBNP-nb-poEaFlsvK1a6S3NpVCz0vcHh0w',
        code_verifier: 'h57bycdwryntewreomnbSyDrAG4kX7BeqS7g-luzvBE'
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
        super.merge(app_id: self.options.client_id, code_challenge: options.client_options.code_challenge)
      end

      def build_access_token
        oauth2_access_token
      end

      def raw_info
        get_user_info
      end

      alias :old_callback_url :callback_url

      def callback_url
        if request.params['callback_url']
          request.params['callback_url']
        else
          old_callback_url
        end
      end
    end
  end
end

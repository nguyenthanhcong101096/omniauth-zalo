require 'omniauth-oauth2'
require 'json'

module OmniAuth
  module Strategies
    class Zalo < OmniAuth::Strategies::OAuth2
      option :name, 'zalo'
      option :fields, 'id,birthday,name,gender,picture'

      option :client_options, {
        site: 'https://oauth.zaloapp.com',
        authorize_url: 'v3/auth',
        token_url: '/v3/access_token'
      }

      def callback_phase
        options[:client_options][:site] = 'https://graph.zalo.me/v2.0/me'
        super
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
      
      uid { raw_info['userId'] }

      info do
        {
          name:        raw_info['displayName'],
          email:       raw_info['email'],
          image:       raw_info['pictureUrl'],
          description: raw_info['statusMessage'],
          info:        raw_info
        }
      end

      def raw_info
        @raw_info ||= JSON.load(access_token.get('v2/profile').body)
      rescue ::Errno::ETIMEDOUT
        raise ::Timeout::Error
      end
    end
  end
end

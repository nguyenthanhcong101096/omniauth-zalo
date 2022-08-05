module OmniAuth
  module Strategies
    module BuildAccessToken
      def oauth2_access_token
        access_token_response = client.request(access_token_method, access_token_url, headers: access_token_headers, parse: :json).parsed

        hash = {
          :access_token => access_token_response["access_token"],
          :expires_in => access_token_response["expires_in"],
        }

        ::OAuth2::AccessToken.from_hash(client, hash)
      end

      def get_user_info
        @raw_info ||= JSON.load(access_token.get("https://graph.zalo.me/v2.0/me?access_token=#{access_token.token}&fields=id,birthday,name,gender,picture,phone").body)
      rescue ::Errno::ETIMEDOUT
        raise ::Timeout::Error
      end

      private

      def access_token_method
        options.client_options.token_method
      end

      def access_token_headers
        { "secret_key" => options.client_secret }
      end

      def access_token_url
        client.token_url(access_token_params)
      end

      def access_token_params
        {}.tap do |params|
          params[:redirect_uri]  = callback_url
          params[:app_id]        = options.client_id
          params[:code]          = request.params['code']
          params[:code_verifier] = options.client_options.code_verifier
          params[:grant_type]    = options.client_options.grant_type
        end
      end
    end
  end
end
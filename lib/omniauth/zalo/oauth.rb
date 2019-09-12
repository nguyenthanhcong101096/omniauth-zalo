# module Omniauth
#   class Zalo::Oauth
#     attr_reader :app_id, :app_secret, :redirect_uri, :state
    
#     # client_options = {
#     #   site: 'https://oauth.zaloapp.com',
#     #   authorize_url: "/v3/auth?app_id=#{app_id}&redirect_uri=#{redirect_uri}&state=#{state}",
#     #   access_token_url: "/v3/access_token?app_id=#{app_id}&app_secret=#{app_secret}&code=#{code}",
#     #   account_info_url: "https://graph.zalo.me/v2.0/me?access_token=#{token}&fields=id,birthday,name,gender,picture,phone"
#     # }
    
#     def initialize(app_id, app_secret, redirect_uri)
#       @app_id       = app_id
#       @app_secret   = app_secret
#       @redirect_uri = redirect_uri
#       @state        = state_hex
#     end
    
#     private
    
#     def state_hex
#       SecureRandom.hex
#     end
#   end
# end

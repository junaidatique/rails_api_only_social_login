module ServicePlatforms
  module Twitter
    class AuthorizationUri
      def initialize(current_user, payload)
        @current_user = current_user
        @payload = payload
      end
      def call
        puts @current_user.inspect
        client  = ServicePlatforms::Twitter::Init.new.call
        request_token = client.get_request_token(oauth_callback: ServicePlatforms::Twitter::Constants::REDIRECT_URI)        
        @payload[:token] = request_token.token
        @payload[:token_secret] = request_token.secret
        @jwt_token  = @current_user.get_jwt(@payload)
        request_token.authorize_url(oauth_callback: ServicePlatforms::Twitter::Constants::REDIRECT_URI, state: @jwt_token)
      end
      
    end
  end
end
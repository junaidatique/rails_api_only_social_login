module ServicePlatforms
  module Twitter
    class HandleOauthResponse
      def initialize oauth_response
        @oauth_response = oauth_response
      end
      def call
        token_values = JWTAuth::JsonWebToken.decode(@oauth_response[:state])
        access_token = ServicePlatforms::Twitter::GetAccessTokenByRequestToken.new(token_values, @oauth_response[:oauth_verifier]).call
        puts access_token.inspect
        ServicePlatforms::Twitter::SaveProfile.new(token_values[:store_id], access_token).call
      end
    end
  end
end
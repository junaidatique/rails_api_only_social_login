module ServicePlatforms
  module Facebook
    class HandleOauthResponse
      def initialize oauth_response
        @oauth_response = oauth_response
      end
      def call
        token_values = JWTAuth::JsonWebToken.decode(@oauth_response[:state])
        ServicePlatforms::Facebook::CheckGrantedScopes.new(@oauth_response[:granted_scopes]).call
        access_token = ServicePlatforms::Facebook::GetAccessToken.new(@oauth_response[:code]).call
        access_token = ServicePlatforms::Facebook::ExtendToken.new(access_token).call        
        ServicePlatforms::Facebook::GetProfile.new(access_token, token_values[:store_id]).call
        ServicePlatforms::Facebook::GetPages.new(access_token, token_values[:store_id]).call
        ServicePlatforms::Facebook::GetGroups.new(access_token, token_values[:store_id]).call
      end
    end
  end
end
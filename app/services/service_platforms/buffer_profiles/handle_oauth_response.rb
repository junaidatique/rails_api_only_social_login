module ServicePlatforms
  module BufferProfiles
    class HandleOauthResponse
      def initialize oauth_response
        @oauth_response = oauth_response
      end
      def call
        token_values = JWTAuth::JsonWebToken.decode(@oauth_response[:state])
        access_token = ServicePlatforms::BufferProfiles::GetAccessToken.new(@oauth_response[:code]).call
        puts access_token
        ServicePlatforms::BufferProfiles::GetProfiles.new(access_token, token_values[:store_id]).call
        # ServicePlatforms::Facebook::GetPages.new(access_token, token_values[:store_id]).call
        # ServicePlatforms::Facebook::GetGroups.new(access_token, token_values[:store_id]).call
      end
    end
  end
end
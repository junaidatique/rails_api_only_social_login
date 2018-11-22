module ServicePlatforms
  module BufferProfiles
    class AuthorizationUri
      def initialize(jwt_token)
        @client     = ServicePlatforms::BufferProfiles::Init.new.call
        @jwt_token  = jwt_token        
        @response_type = ServicePlatforms::BufferProfiles::Constants::RESPONSE_TYPE
      end
      def call
        # puts @client.inspect
        authorization_uri = @client.authorization_uri(
          scope: @scope,
          state: @jwt_token,
          response_type: @response_type
        )
      end
      
    end
  end
end
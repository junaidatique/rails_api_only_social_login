module ServicePlatforms
  module BufferProfiles
    class AuthorizationUri
      def initialize(current_user, payload)        
        @jwt_token  = current_user.get_jwt(payload)        
      end
      def call        
        client     = ServicePlatforms::BufferProfiles::Init.new.call
        response_type = ServicePlatforms::BufferProfiles::Constants::RESPONSE_TYPE
        authorization_uri = client.authorization_uri(
          scope: @scope,
          state: @jwt_token,
          response_type: response_type
        )
      end
      
    end
  end
end
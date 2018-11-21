module ServicePlatforms
  module Facebook
    class RerequestUri
      def initialize(jwt_token, scope)        
        @jwt_token  = jwt_token
        @scope = scope
      end
      def call        
        client  = ServicePlatforms::Facebook::Init.new.call        
        authorization_uri = client.authorization_uri(
          scope: @scope,
          state: @jwt_token,
          auth_type: 'rerequest'
        )
      end
      
    end
  end
end
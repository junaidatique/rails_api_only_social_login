module ServicePlatforms
  module Facebook
    class AuthorizationUri
      def initialize(jwt_token)        
        @jwt_token  = jwt_token        
      end
      def call        
        client  = ServicePlatforms::Facebook::Init.new.call
        scope   = ServicePlatforms::Facebook::Constants::SCOPE
        authorization_uri = client.authorization_uri(
          scope: scope,
          state: @jwt_token,
          response_type: 'code,granted_scopes'
        )
      end
      
    end
  end
end
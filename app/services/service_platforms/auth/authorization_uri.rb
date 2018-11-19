module ServicePlatforms
  module Auth
    class AuthorizationUri
      def initialize(client, jwt_token, scope)
        @client     = client
        @jwt_token  = jwt_token
        @scope      = scope
      end
      def call
        # puts @client.inspect
        authorization_uri = @client.authorization_uri(
          scope: @scope,
          state: @jwt_token,
          response_type: 'code,granted_scopes'
        )
      end
      
    end
  end
end
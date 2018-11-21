module ServicePlatforms
  module Auth
    class AuthorizationUri
      def initialize(client, jwt_token, scope, response_type)
        @client     = client
        @jwt_token  = jwt_token
        @scope      = scope
        @response_type = response_type
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
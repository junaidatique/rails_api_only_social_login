module ServicePlatforms
  module Auth
    class GetAccessToken

      def initialize code, token 
        @code = code
        @token = token
      end
      

      def call()        
        response = HTTParty.get(@token.token_endpoint, query(@code))
        puts response.parsed_response.inspect        
        unless response.success?
          Rails.logger.error 'Omniauth.get_access_token Failed'
          return response.parsed_response['error']['message']
        end
        response.parsed_response['access_token']
      end
      

      private
      def query(code)
        {
          query: {
            code: code,
            redirect_uri: @token.redirect_uri,
            client_id: @token.identifier,
            client_secret: @token.secret
          }
        }
      end
    end
  end
end

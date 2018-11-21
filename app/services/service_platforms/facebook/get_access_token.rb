module ServicePlatforms
  module Facebook
    class GetAccessToken

      def initialize code
        @code = code
        @client = ServicePlatforms::Facebook::Init.new.call      
      end
      

      def call()
        response = HTTParty.get(@client.token_endpoint, query(@code))        
        unless response.success?
          Rails.logger.error "Facebook GetAccessToken Failed #{response.parsed_response['error']['message']}"
          raise(ServicePlatforms::ExceptionHandler::InvalidToken, response.parsed_response['error']['message'])          
        end
        response.parsed_response['access_token']
      end
      

      private
      def query(code)
        {          
          query: {
            code: code,
            redirect_uri: @client.redirect_uri,
            client_id: @client.identifier,
            client_secret: @client.secret
          }
        }
      end
    end
  end
end

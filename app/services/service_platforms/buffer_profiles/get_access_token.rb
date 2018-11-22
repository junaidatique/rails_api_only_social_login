module ServicePlatforms
  module BufferProfiles
    class GetAccessToken

      def initialize code
        @code = code
        @client = ServicePlatforms::BufferProfiles::Init.new.call              
      end
      

      def call()                
        response = HTTParty.post(@client.token_endpoint, :body => query())        
        unless response.success?
          Rails.logger.error "Buffer GetAccessToken Failed #{response.parsed_response['error_description']}"
          raise(ServicePlatforms::ExceptionHandler::InvalidToken, response.parsed_response['error_description'])          
        end
        response.parsed_response['access_token']        
      end
      

      private
      def query()
        {
          code: @code,
          redirect_uri: @client.redirect_uri,
          client_id: @client.identifier,
          client_secret: @client.secret,
          grant_type: ServicePlatforms::BufferProfiles::Constants::GRANT_TYPE          
        }
      end
    end
  end
end

module ServicePlatforms
  module Buffer
    class GetAccessToken

      def initialize code
        @code = code
        @token = token
        @grant_type = grant_type
      end
      

      def call()        
        # query_param = query(@code)
        # query_param[:grant_type] = @grant_type unless @grant_type.blank?
        # puts query_param.inspect
        # response = HTTParty.post(@token.token_endpoint, query(@code))
        response = HTTParty.post(@token.token_endpoint, :body => query(@code, @grant_type))

        
        unless response.success?
          Rails.logger.error 'Omniauth.get_access_token Failed'
          return response.parsed_response['error']['message']
        end
        response.parsed_response['access_token']
      end
      

      private
      def query(code, grant_type)
        {
          code: code,
          redirect_uri: @token.redirect_uri,
          client_id: @token.identifier,
          client_secret: @token.secret,
          grant_type: grant_type
          # query: {
            
          # }
        }
      end
    end
  end
end

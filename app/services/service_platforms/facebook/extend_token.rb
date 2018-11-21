module ServicePlatforms
  module Facebook
    class ExtendToken
      def initialize access_token
        @access_token = access_token
      end        
      def call        
        client_id = Rails.application.credentials[Rails.env.to_sym][:FACEBOOK_CLIENT_ID]
        client_secret = Rails.application.credentials[Rails.env.to_sym][:FACEBOOK_CLIENT_SECRET]
        auth = FbGraph2::Auth.new(client_id, client_secret)
        puts auth.inspect
        auth.fb_exchange_token = @access_token
        puts auth.inspect
        access_token = auth.access_token!
        puts access_token.inspect
        if access_token.blank?
          raise ServicePlatforms::ExceptionHandler::InvalidToken, "Invalid token to extend"
        end
        return access_token
      end
    end
  end
end

module ServicePlatforms
  module Buffer
    class Init
      def call
        return Rack::OAuth2::Client.new(
          identifier: Rails.application.credentials[Rails.env.to_sym][:BUFFER_CLIENT_ID],
          secret: Rails.application.credentials[Rails.env.to_sym][:BUFFER_CLIENT_SECRET],
          redirect_uri: ServicePlatforms::Buffer::Constants::REDIRECT_URI,
          authorization_endpoint: ServicePlatforms::Buffer::Constants::AUTH_ENDPOINT,
          token_endpoint: ServicePlatforms::Buffer::Constants::TOKEN_ENDPOINT
        )
      end
      
    end
  end
end
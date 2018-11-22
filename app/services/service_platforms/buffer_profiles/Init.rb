module ServicePlatforms
  module BufferProfiles
    class Init
      def call
        return Rack::OAuth2::Client.new(
          identifier: Rails.application.credentials[Rails.env.to_sym][:BUFFER_CLIENT_ID],
          secret: Rails.application.credentials[Rails.env.to_sym][:BUFFER_CLIENT_SECRET],
          redirect_uri: ServicePlatforms::BufferProfiles::Constants::REDIRECT_URI,
          authorization_endpoint: ServicePlatforms::BufferProfiles::Constants::AUTH_ENDPOINT,
          token_endpoint: ServicePlatforms::BufferProfiles::Constants::TOKEN_ENDPOINT
        )
      end
      
    end
  end
end
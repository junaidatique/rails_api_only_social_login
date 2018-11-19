module ServicePlatforms
  module Facebook
    class Init
      def call
        return Rack::OAuth2::Client.new(
          identifier: Rails.application.credentials[Rails.env.to_sym][:FACEBOOK_CLIENT_ID],
          secret: Rails.application.credentials[Rails.env.to_sym][:FACEBOOK_CLIENT_SECRET],
          redirect_uri: ServicePlatforms::Facebook::Constnt::REDIRECT_URI,
          authorization_endpoint: ServicePlatforms::Facebook::Constnt::AUTH_ENDPOINT,
          token_endpoint: ServicePlatforms::Facebook::Constnt::TOKEN_ENDPOINT
        )
      end
      
    end
  end
end
module ServicePlatforms
  module Facebook
    class Init
      def call
        return Rack::OAuth2::Client.new(
          identifier: Rails.application.credentials[Rails.env.to_sym][:FACEBOOK_CLIENT_ID],
          secret: Rails.application.credentials[Rails.env.to_sym][:FACEBOOK_CLIENT_SECRET],
          redirect_uri: "#{Rails.application.credentials[Rails.env.to_sym][:FRONTEND_HOST]}oauth/facebook",
          authorization_endpoint: "#{ServicePlatforms::Facebook::Constnt::WEB_URL}dialog/oauth",
          token_endpoint: "#{ServicePlatforms::Facebook::Constnt::API_URL}oauth/access_token"
        )
      end
      
    end
  end
end
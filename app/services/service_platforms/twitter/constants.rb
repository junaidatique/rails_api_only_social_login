module ServicePlatforms
  module Twitter
    class Constants
      API_VERSION = ""
      WEB_URL = "https://twitter.com/"
      API_URL = "https://api.twitter.com"
      SCOPE = ""
      REDIRECT_URI = "#{Rails.application.credentials[Rails.env.to_sym][:FRONTEND_HOST]}oauth/twitter"
      AUTH_ENDPOINT = "#{ServicePlatforms::Twitter::Constants::API_URL}oauth/authenticate"
      TOKEN_ENDPOINT = "#{ServicePlatforms::Twitter::Constants::API_URL}oauth/access_token"
    end
  end
end
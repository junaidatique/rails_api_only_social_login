module ServicePlatforms
  module BufferProfiles
    class Constants
      API_VERSION = "1"
      WEB_URL = "https://bufferapp.com/"
      API_URL = "https://api.bufferapp.com/1/"
      SCOPE = ""
      RESPONSE_TYPE = "code"
      GRANT_TYPE = "authorization_code"
      REDIRECT_URI = "#{Rails.application.credentials[Rails.env.to_sym][:FRONTEND_HOST]}api/v1/oauth/buffer"
      AUTH_ENDPOINT = "#{ServicePlatforms::BufferProfiles::Constants::WEB_URL}oauth2/authorize"
      TOKEN_ENDPOINT = "#{ServicePlatforms::BufferProfiles::Constants::API_URL}oauth2/token.json"

    end
  end
end
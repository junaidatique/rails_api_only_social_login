module ServicePlatforms
  module Facebook
    class Constnt
      API_VERSION = "v3.2"
      WEB_URL = "https://web.facebook.com/v3.2/"
      API_URL = "https://graph.facebook.com/v3.2/"
      SCOPE = "email,manage_pages,read_insights,publish_pages"
      REDIRECT_URI = "#{Rails.application.credentials[Rails.env.to_sym][:FRONTEND_HOST]}oauth/facebook"
      AUTH_ENDPOINT = "#{ServicePlatforms::Facebook::Constnt::WEB_URL}dialog/oauth"
      TOKEN_ENDPOINT = "#{ServicePlatforms::Facebook::Constnt::API_URL}oauth/access_token"
    end
  end
end
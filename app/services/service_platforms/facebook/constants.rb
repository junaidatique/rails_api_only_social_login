module ServicePlatforms
  module Facebook
    class Constants
      API_VERSION = "v3.2"
      WEB_URL = "https://web.facebook.com/"
      API_URL = "https://graph.facebook.com/"
      SCOPE = "email,user_link,manage_pages,read_insights,publish_pages,publish_to_groups"
      RESPONSE_TYPE = "code,granted_scopes"
      GRANT_TYPE = nil
      REDIRECT_URI = "#{Rails.application.credentials[Rails.env.to_sym][:FRONTEND_HOST]}api/v1/oauth/facebook"
      AUTH_ENDPOINT = "#{ServicePlatforms::Facebook::Constants::WEB_URL}#{ServicePlatforms::Facebook::Constants::API_VERSION}/dialog/oauth"
      TOKEN_ENDPOINT = "#{ServicePlatforms::Facebook::Constants::API_URL}#{ServicePlatforms::Facebook::Constants::API_VERSION}/oauth/access_token"
    end
  end
end
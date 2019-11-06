module ServicePlatforms
  module Twitter
    class GetAccessToken
      def initialize oauth_token, oauth_token_secret 
        @oauth_token        = oauth_token
        @oauth_token_secret = oauth_token_secret
      end

      def call()                        
        consumer = OAuth::Consumer.new(oauth_token, oauth_token_secret, site: ServicePlatforms::Twitter::Constants::API_URL)
        
        hash = { token: @oauth_token, secret: @oauth_token_secret}
        access_token  = OAuth::AccessToken.from_hash(client, hash)                
      end
    end
  end
end

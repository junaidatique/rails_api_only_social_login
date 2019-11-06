module ServicePlatforms
  module Twitter
    class GetAccessTokenByRequestToken
      def initialize token_values, oauth_verifier
        @token_values = token_values        
        @oauth_verifier = oauth_verifier
      end      

      def call()                
        client        = ServicePlatforms::Twitter::Init.new.call        
        hash          = { oauth_token: @token_values[:token], oauth_token_secret: @token_values[:token_secret]}
        request_token = OAuth::RequestToken.from_hash(client, hash)        
        access_token  = request_token.get_access_token(oauth_verifier: @oauth_verifier)        
      end
    end
  end
end

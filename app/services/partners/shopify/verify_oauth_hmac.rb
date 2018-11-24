module Partners
  module Shopify
    class VerifyOauthHmac
      def initialize(hmac, message)
        @hmac = hmac
        @message = message
      end
      def call
        digest = OpenSSL::Digest.new('sha256')        
        api_secret  = Rails.application.credentials[Rails.env.to_sym][:SHOPIFY_API_SECRET]
        digest      = OpenSSL::HMAC.hexdigest(digest, api_secret, @message)
        puts digest.inspect
        ActiveSupport::SecurityUtils.secure_compare(digest, @hmac)
      end
    end
  end
end
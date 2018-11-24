module Partners
  module Shopify
    class ActivateSession
      def initialize(shop, token)
        @shop  = shop
        @token = token
      end
      def call
        api_key = Rails.application.credentials[Rails.env.to_sym][:SHOPIFY_API_KEY]
        api_secret = Rails.application.credentials[Rails.env.to_sym][:SHOPIFY_API_SECRET]        
        ShopifyAPI::Session.setup(api_key: api_key, secret: api_secret)
        session = ShopifyAPI::Session.new(@shop, @token)
        ShopifyAPI::Base.activate_session(session)
        return session
      end
    end
  end
end
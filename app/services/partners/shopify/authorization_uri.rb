module Partners
  module Shopify
    class AuthorizationUri
      def initialize(options = {})
        @url = options[:shop]
        @state = options[:jwt_token]
      end
      def call
        api_key = Rails.application.credentials[Rails.env.to_sym][:SHOPIFY_API_KEY]
        api_secret = Rails.application.credentials[Rails.env.to_sym][:SHOPIFY_API_SECRET]
        ShopifyAPI::Session.setup(api_key: api_key, secret: api_secret)
        session = ShopifyAPI::Session.new(@url)
        scope   = Partners::Shopify::Constants::SCOPE
        redirect_url   = Partners::Shopify::Constants::REDIRECT_URI         
        permission_url = session.create_permission_url(scope, redirect_url)
        return "#{permission_url}&state=#{@state}"
      end
      
    end
  end
end
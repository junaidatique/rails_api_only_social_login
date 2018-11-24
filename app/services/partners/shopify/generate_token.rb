module Partners
  module Shopify
    class GenerateToken
      def initialize(autherize_params)
        @autherize_params  = autherize_params        
      end
      def call        
        api_key = Rails.application.credentials[Rails.env.to_sym][:SHOPIFY_API_KEY]
        api_secret = Rails.application.credentials[Rails.env.to_sym][:SHOPIFY_API_SECRET]        
        ShopifyAPI::Session.setup(api_key: api_key, secret: api_secret)
        session = ShopifyAPI::Session.new(@autherize_params[:shop])        
        return token = session.request_token(@autherize_params)
      end
    end
  end
end
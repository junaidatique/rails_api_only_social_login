module Partners
  module Shopify
    class CreateWebhooks
      def initialize(store_id)
        @store_id = store_id
      end
      def call
        store = Store.find(@store_id)        
        session = Partners::Shopify::ActivateSession.new(store.partner_specific_url, store.partner_token).call
        ShopifyAPI::Webhook.create(:topic => "app/uninstalled", :format  => "json", :address => "http://your-url.com/uninstall")

      end
    end
  end
end
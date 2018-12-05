module Partners
  module Shopify
    class CreateWebhooks
      def initialize(store_id)
        @store_id = store_id
      end      
      def call
        store = Store.find(@store_id)
        session = Partners::Shopify::ActivateSession.new(store.partner_specific_url, store.partner_token).call
        api_host = Rails.application.credentials[Rails.env.to_sym][:API_HOST]        
        webhooks_list = ['collections/create', 'collections/delete', 'collections/update','products/create','products/delete', 'products/update','app/uninstalled', 'shop/update']
        shop_webhooks = ShopifyAPI::Webhook.find(:all)
        webhook_call = Array.new
        webhooks_list.each do |webhook|
          if shop_webhooks.map{|w| 1 if w.topic == webhook}.reject{|w| w.blank?}.first.blank?
            url = "#{api_host}webhook/#{webhook.gsub('/','_')}/shopify"        
            ShopifyAPI::Webhook.create(topic: webhook, format: "json", address: url)
          end
        end        
      end
    end
  end
end
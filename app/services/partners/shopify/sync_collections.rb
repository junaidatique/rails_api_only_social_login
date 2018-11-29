module Partners
  module Shopify
    class SyncCollections
      def initialize(partner_slug, store_id)
        @store_id        = store_id        
        @partner_slug        = partner_slug        
      end
      def call
        store = Store.find(@store_id)
        limit = Partners::Shopify::Constants::API_CALL_LIMIT
        session = Partners::Shopify::ActivateSession.new(store.partner_specific_url, store.partner_token).call
        smart_collection_count = ShopifyAPI::SmartCollection.count
        total_pages = (smart_collection_count / limit) + 1
        smart_collection_options = {}
        smart_collection_options[:type] = Partners::Shopify::Constants::SMART_COLLECTION
        if smart_collection_count > 0
          (1..total_pages).each do |page_id|          
            SyncCollectionPagedJob.perform_later @partner_slug, @store_id, page_id, smart_collection_options
          end
        end
        custom_collection_count = ShopifyAPI::CustomCollection.count
        total_pages = (custom_collection_count / limit) + 1
        custom_collection_options = {}
        custom_collection_options[:type] = Partners::Shopify::Constants::CUSTOM_COLLECTION
        (1..total_pages).each do |page_id|
          SyncCollectionPagedJob.perform_later @partner_slug, @store_id, page_id, custom_collection_options
        end
      end
    end
  end
end
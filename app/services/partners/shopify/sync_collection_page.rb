module Partners
  module Shopify
    class SyncCollectionPage
      def initialize(partner_slug, store_id, page_id, options)
        @store_id        = partner_slug        
        @store_id        = store_id        
        @page_id        = page_id        
        @options        = options
      end
      def call
        store = Store.find(@store_id)
        limit = Partners::Shopify::Constants::API_CALL_LIMIT
        session = Partners::Shopify::ActivateSession.new(store.partner_specific_url, store.partner_token).call
        if @options[:type] == Partners::Shopify::Constants::SMART_COLLECTION
          collections  = ShopifyAPI::SmartCollection.find(:all, params: {limit: limit, page: @page_id} )
        else 
          collections = ShopifyAPI::CustomCollection.find(:all, params: {limit: limit, page: @page_id} )
        end        
        bulk_order = collections.map do |collection|
          { update_one:
            {
              filter: { uniq_key: "#{Partners::Constants::SHOPIFY_SLUG}-#{collection.id}" },
              update: { :'$set' => {
                title: collection.title,
                slug: collection.handle,
                url: "://#{store.url}/#{collection.handle}",
                partner_id: collection.id,
                partner_name: collection.title,
                partner_created_at: collection.updated_at,
                partner_updated_at: collection.updated_at,
                partner_slug: Partners::Constants::SHOPIFY_SLUG,                
                uniq_key: "#{Partners::Constants::SHOPIFY_SLUG}-#{collection.id}",
                description: collection.body_html,
                is_published: !collection.published_at.blank?,
                store_id: store.id,
              }},
              upsert: true
            }
          }
        end        
        Category.collection.bulk_write(bulk_order)
        category_uniq_keys = collections.map{|collection| "#{Partners::Constants::SHOPIFY_SLUG}-#{collection.id}"}
        db_categories = Category.in(uniq_key: category_uniq_keys)
        db_categories.each do |category|
          SyncProductsJob.perform_later(Partners::Constants::SHOPIFY_SLUG, store.id.to_s, category.id.to_s)
        end
      end
    end
  end
end
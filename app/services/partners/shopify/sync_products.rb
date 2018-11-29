module Partners
  module Shopify
    class SyncProducts
      def initialize(partner_slug, store_id, category_id)
        @store_id       = store_id
        @partner_slug   = partner_slug
        @category_id    = category_id
      end
      def call
        store = Store.find(@store_id)
        limit = Partners::Shopify::Constants::API_CALL_LIMIT
        session = Partners::Shopify::ActivateSession.new(store.partner_specific_url, store.partner_token).call
        if @category_id.present?
          category = Category.find(@category_id)
          total_products = ShopifyAPI::Product.count({collection_id: category.partner_id})
        else
          total_products = ShopifyAPI::Product.count()
          total_active_products = ShopifyAPI::Product.count({published_status: 'published'})
          store.number_of_products = total_products
          store.no_of_active_products = total_active_products
          store.save
        end
        
        total_pages = (total_products / limit) + 1
        (1..total_pages).each do |page_id|
          SyncProductPagedJob.perform_later @partner_slug, @store_id, page_id, @category_id
        end
        
      end
    end
  end
end
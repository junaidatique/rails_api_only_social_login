module Partners
  module Shopify
    class SyncProductPage
      def initialize(partner_slug, store_id, page_id, category_id)
        @store_id        = partner_slug        
        @store_id        = store_id        
        @page_id         = page_id        
        @category_id     = category_id
      end
      def call
        store = Store.find(@store_id)
        limit = Partners::Shopify::Constants::API_CALL_LIMIT
        session = Partners::Shopify::ActivateSession.new(store.partner_specific_url, store.partner_token).call
        if @category_id.present?
          category = Category.find(@category_id)
          products = ShopifyAPI::Product.find(:all, params: {limit: limit, page: @page_id, collection_id: category.partner_id} )
        else
          products = ShopifyAPI::Product.find(:all, params: {limit: limit, page: @page_id} )
        end        
        bulk_products = products.map do |product|
          { update_one:
            {
              filter: { uniq_key: "#{Partners::Constants::SHOPIFY_SLUG}-#{product.id}" },
              update: { :'$set' => {
                title: product.title,
                slug: product.handle,
                url: "://#{store.url}/#{product.handle}",
                partner_id: product.id,
                partner_name: product.title,
                partner_created_at: product.created_at,
                partner_updated_at: product.updated_at,
                partner_slug: Partners::Constants::SHOPIFY_SLUG,
                uniq_key: "#{Partners::Constants::SHOPIFY_SLUG}-#{product.id}",
                description: Partners::SanitizeHtml.new(product.body_html).call,
                is_published: (!product.published_at.blank?),
                store_id: store.id,                
                }},
              upsert: true
            }
          }
        end        
        Product.collection.bulk_write(bulk_products)        
        product_uniq_keys = products.map{|product| "#{Partners::Constants::SHOPIFY_SLUG}-#{product.id}"}
        db_products = Product.in(uniq_key: product_uniq_keys)
        
        if @category_id.present?
          category = Category.find(@category_id)
          db_products.each do |product|
            product.categories << category
            product.save
          end
        else
        
          bulk_images = []
          products.each do |product|
            db_product = db_products.where(uniq_key: "#{Partners::Constants::SHOPIFY_SLUG}-#{product.id}").first                    
            bulk_images << product.images.map do |product_image|
              { update_one:
                {
                  filter: { uniq_key: "#{Partners::Constants::SHOPIFY_SLUG}-#{product_image.id}" },
                  update: { :'$set' => {                  
                    url: product_image.src,
                    thumbnail_url: Partners::Shopify::CreateThumbnailUrl.new(product_image.src).call,
                    partner_id: product_image.id,                  
                    partner_created_at: product_image.created_at,
                    partner_updated_at: product_image.updated_at,
                    position: product_image.position,
                    partner_slug: Partners::Constants::SHOPIFY_SLUG,
                    uniq_key: "#{Partners::Constants::SHOPIFY_SLUG}-#{product_image.id}",                  
                    is_published: true,                  
                    product_id: db_product.id
                  }},
                  upsert: true
                }
              }          
            end          
          end
          Image.collection.bulk_write(bulk_images.flatten)

          bulk_variants = []
          products.each do |product|
            db_product = db_products.where(uniq_key: "#{Partners::Constants::SHOPIFY_SLUG}-#{product.id}").first                    
            bulk_variants << product.variants.map do |product_variant|
              { update_one:
                {
                  filter: { uniq_key: "#{Partners::Constants::SHOPIFY_SLUG}-#{product_variant.id}" },
                  update: { :'$set' => {                                    
                    title: product_variant.title,                  
                    original_price: product_variant.compare_at_price.to_f,
                    price: product_variant.price.to_f,
                    on_sale: (product_variant.compare_at_price.present? and product_variant.compare_at_price != product_variant.price) ? true : false,
                    image_external_keys: ["#{Partners::Constants::SHOPIFY_SLUG}-#{product_variant.image_id}"],
                    partner_id: product_variant.id,                  
                    partner_created_at: product_variant.created_at,
                    partner_updated_at: product_variant.updated_at,
                    position: product_variant.position,
                    quantity: product_variant.inventory_quantity,
                    partner_slug: Partners::Constants::SHOPIFY_SLUG,
                    uniq_key: "#{Partners::Constants::SHOPIFY_SLUG}-#{product_variant.id}",                  
                    is_published: true,                  
                    product_id: db_product.id
                  }},
                  upsert: true
                }
              }          
            end          
          end
          Variant.collection.bulk_write(bulk_variants.flatten)


          db_products = Product.in(uniq_key: product_uniq_keys).includes(:variants)
          bulk_products_update = []
          bulk_products_update = db_products.map do |product|
            { update_one:
              {
                filter: { uniq_key: "#{Partners::Constants::SHOPIFY_SLUG}-#{product.partner_id}" },
                update: { :'$set' => {
                  quantity: product.variants.sum(:quantity),
                  minimum_price: product.variants.gt(price: 0).min(:price),
                  maximum_price: product.variants.gt(price: 0).min(:price),
                  on_sale: (product.variants.where(on_sale: true).count > 0) ? true : false,
                  postable_by_quantity: (product.variants.sum(:quantity) > 0) ? true : false,
                  postable_by_price: (product.variants.gt(price: 0).min(:price) > 0) ? true : false,
                  postable_is_new: (7.days.ago <= product.partner_created_at) ? true : false,
                }}              
              }
            }
          end
          Product.collection.bulk_write(bulk_products_update)
        end
      end
    end
  end
end
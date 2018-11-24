module Partners
  module Shopify
    class FirstOrCreate
      def initialize(user_id, shop, token)
        @user_id  = user_id
        @shop     = shop
        @token    = token
      end
      def call
        session = Partners::Shopify::ActivateSession.new(@shop, @token)        
        shop_current = ShopifyAPI::Shop.current
        uniq_key = "#{Partners::Constants::SHOPIFY_SLUG}-#{shop_current.id}"
        store = Store.where(uniq_key: uniq_key).first_or_create
        store.title   = shop_current.name
        store.url = shop_current.domain
        store.partner_id = shop_current.id
        store.partner_name = shop_current.name
        store.partner_specific_url = shop_current.myshopify_domain
        store.partner_created_at = shop_current.created_at
        store.partner_updated_at = shop_current.updated_at
        store.uniq_key = uniq_key
        store.partner_token = @token
        store.timezone = shop_current.iana_timezone
        store.currency = shop_current.money_format
        store.money_with_currency_format = shop_current.money_with_currency_format
        store.user_id = @user_id
        store.save!
        return store
        
      end
    end
  end
end
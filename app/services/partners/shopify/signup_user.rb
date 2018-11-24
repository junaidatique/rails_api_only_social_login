module Partners
  module Shopify
    class SignupUser
      def initialize(shop, token)
        @shop  = shop
        @token = token
      end
      def call        
        puts @shop.inspect
        puts @token        
        session = Partners::Shopify::ActivateSession.new(@shop, @token).call
        shop_current = ShopifyAPI::Shop.current
        email = shop_current.customer_email        
        user = User.where(email: email).first        
        if user.blank?
          user = User.create!({email: email, password: Devise.friendly_token[0,20] })
        end
        user.touch
        return user
      end
    end
  end
end
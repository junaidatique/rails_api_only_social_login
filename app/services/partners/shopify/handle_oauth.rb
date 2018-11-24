module Partners
  module Shopify
    class HandleOauth
      def initialize(jwt_token, autherize_params)
        @jwt_token        = jwt_token
        @autherize_params = autherize_params.except(:partner_platform)
      end
      def call
        shop_url = @autherize_params[:shop]
        store = Store.where(partner_specific_url: shop_url).first
        if store.blank?
          token = Partners::Shopify::GenerateToken.new(@autherize_params).call          
          user  = Partners::Shopify::SignupUser.new(@autherize_params[:shop], token).call
          store = Partners::Shopify::FirstOrCreate.new(user.id, @autherize_params[:shop], token).call          
        end
        puts store.inspect
      end
    end
  end
end
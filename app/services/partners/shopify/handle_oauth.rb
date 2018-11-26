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
          if jwt_token[:user_id].present? and User.find(jwt_token[:user_id]).present?
            user  = User.find(jwt_token[:user_id])
          else
            user  = Partners::Shopify::SignupUser.new(@autherize_params[:shop], token).call
          end
          store = Partners::Shopify::FirstOrCreateStore.new(user.id, @autherize_params[:shop], token).call    
        end
        SyncCollectionsJob.perform_later(Partners::Constants::SHOPIFY_SLUG, store.id.to_s)
        SyncProductsJob.perform_later(Partners::Constants::SHOPIFY_SLUG, store.id.to_s)
      end
    end
  end
end
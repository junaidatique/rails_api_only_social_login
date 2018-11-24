module Partners
  module Shopify    
    class Constants      
      SCOPE = ["read_products","read_orders"]      
      REDIRECT_URI = "#{Rails.application.credentials[Rails.env.to_sym][:FRONTEND_HOST]}api/v1/partner/autherize/shopify"
      
      
    end
  end
end
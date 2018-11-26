module Partners
  module Shopify    
    class Constants      
      SCOPE = ["read_products","read_orders"]      
      REDIRECT_URI = "#{Rails.application.credentials[Rails.env.to_sym][:FRONTEND_HOST]}api/v1/partner/autherize/shopify"
      API_CALL_LIMIT = 250
      SMART_COLLECTION  = 'SMART_COLLECTION'
      CUSTOM_COLLECTION = 'CUSTOM_COLLECTION'
      
      
    end
  end
end
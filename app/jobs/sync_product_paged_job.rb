class SyncProductPagedJob < ApplicationJob  
  queue_as do    
    if Rails.env.staging?
      :default
    else
      :store_products
    end
  end
  def perform(partner_slug, store_id, page_id, category_id = nil)
    partner   = Partners::Build.new(partner_slug).call
    response  = partner::SyncProductPage.new(partner_slug, store_id, page_id, category_id).call
  end
end

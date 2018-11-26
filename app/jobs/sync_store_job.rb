class SyncStoreJob < ApplicationJob
  # queue_as :default
  queue_as do    
    if Rails.env.staging?
      :default
    else
      :store_queue
    end
  end
  def perform(store_id)
    store = Store.find(store_id)
    partner_slug  = store.slug
    partner       = Partners::Build.new(partner_slug).call
    partner::FirstOrCreateStore.new(store.user.id, store.partner_specific_url, store.partner_token).call
    partner::SyncCollections.new(store.id).call
    partner::CalculateProducts.new(store.id).call
  end
end

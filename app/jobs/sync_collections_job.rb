class SyncCollectionsJob < ApplicationJob
  # queue_as :store_collection
  queue_as do    
    if Rails.env.staging?
      :default
    else
      :store_collection
    end
  end

  def perform(partner_slug, store_id)
    partner   = Partners::Build.new(partner_slug).call
    response  = partner::SyncCollections.new(partner_slug, store_id).call
  end
end

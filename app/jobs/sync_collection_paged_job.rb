class SyncCollectionPagedJob < ApplicationJob
  # queue_as :default
  queue_as :store_collection
  def perform(partner_slug, store_id, page_id, options)
    partner   = Partners::Build.new(partner_slug).call
    response  = partner::SyncCollectionPage.new(partner_slug, store_id, page_id, options).call
  end
end

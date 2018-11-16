json.stores @current_user.stores.published do |store|
  json.partial! 'store_detail', store: store
end
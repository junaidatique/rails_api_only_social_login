json.user do
  json.partial! 'api/v1/users/user', user: @current_user
end
if @current_user.number_of_stores > 0
  if @current_user.number_of_stores > 1
    json.stores @current_user.stores.published do |store|
      json.partial! 'api/v1/stores/store', store: store
    end
  else
    json.store do
      json.partial! 'api/v1/stores/store_detail', store: @current_user.stores.published.first
    end
  end
end
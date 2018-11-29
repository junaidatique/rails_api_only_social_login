web: bundle exec rails s -p 3005
store_collection_worker: bundle exec sidekiq -q store_collection -c 1 
store_products_worker: bundle exec sidekiq -q store_products -c 1 
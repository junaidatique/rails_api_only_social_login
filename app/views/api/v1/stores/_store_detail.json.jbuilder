json.title store.title
json.url store.url
json.description store.description
json.timezone store.timezone
json.partial! 'api/v1/service_platforms/service_platforms', store: store

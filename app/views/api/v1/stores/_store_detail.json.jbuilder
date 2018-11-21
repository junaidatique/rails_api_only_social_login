json.partial! 'api/v1/stores/store', store: store
json.service_platforms ServicePlatform.all do |service_platform|
  json.partial! 'api/v1/service_platforms/service_platform', store: store, service_platform: service_platform, profiles: store.profiles.where(service_platform_id: service_platform.id).connected
end


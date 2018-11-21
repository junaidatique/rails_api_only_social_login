json.service_platforms ServicePlatform.all do |service_platform|
  json.id service_platform.id.to_s
  json.name service_platform.name
  json.share_options service_platform.share_options
  json.partial! 'api/v1/profiles/profiles', profiles: store.profiles.where(service_platform_id: service_platform.id).connected
end
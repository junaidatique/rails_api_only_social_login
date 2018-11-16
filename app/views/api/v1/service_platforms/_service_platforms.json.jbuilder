json.service_platforms ServicePlatform.all do |service_platform|
  json.name service_platform.name
  json.profiles store.profiles.where(service_platform_id: service_platform.id).connected do |profile|    
    json.servie_name profile.service.name
    json.servie_character_limit profile.service.character_limit
    json.servie_can_schedule profile.service.can_schedule
    json.name profile.name
    json.avatar_url profile.avatar_url    
    json.formatted_username profile.formatted_username
    json.service_slug profile.service_slug
    json.url profile.url
  end
end
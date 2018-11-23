module ServicePlatforms
  module BufferProfiles
    class GetProfiles
      def initialize access_token, store_id
        @access_token = access_token
        @store_id = store_id
      end
      def call
        client = Buffer::Client.new(@access_token)
        
        service = Service.where(slug: ServicePlatforms::Constants::BUFFER_PROFILE_SLUG).first
        buffer_platform = ServicePlatform.where(slug: ServicePlatforms::Constants::BUFFER_SLUG).first
        insta_platform = ServicePlatform.where(slug: ServicePlatforms::Constants::BUFFER_INSTAGRAM_NAME).first
        service_profile = client.user_info
        puts service_profile.inspect
        puts service_profile.name
        profile = Profile.where(
          service_id: service.id, 
          service_user_id: service_profile.id,          
          store_id: @store_id
        ).first_or_create
        profile.name = service_profile.name
        profile.access_token = @access_token          
        profile.url = nil
        profile.avatar_url = nil
        profile.service_slug = service.slug
        profile.service_platform = buffer_platform
        profile.is_token_expired = false
        profile.save
        parent_profile_id = profile.id

        service_profiles = client.profiles        
        service_profiles.each do |service_profile|
          if service_profile.service == ServicePlatforms::Constants::INSTAGRAM_NAME
            service_platform = insta_platform
          else
            service_platform = buffer_platform
          end
          service_slug  = "buffer_#{service_profile.service}_#{service_profile.service_type}"
          service = Service.where(slug: service_slug).first
          puts service_slug
          profile = Profile.where(
            service_platform_id: service_platform.id, 
            service_user_id: service_profile.service_id,          
            service_id: service.id,          
            store_id: @store_id
          ).first_or_create
          profile.buffer_id     = service_profile.id
          profile.name          = service_profile.service_username
          profile.service_username = service_profile.service_username
          profile.access_token  = @access_token
          profile.url           = nil
          profile.avatar_url    = service_profile.avatar_https
          profile.service_slug  = "buffer_#{service_profile.service}_#{service_profile.service_type}"
          
          profile.is_token_expired    = false
          profile.parent_profile_id   = parent_profile_id
          profile.save!
        end
      end
    end
  end
end
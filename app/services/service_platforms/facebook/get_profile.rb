module ServicePlatforms
  module Facebook
    class GetProfile
      def initialize access_token, store_id
        @access_token = access_token        
        @store_id   = store_id
      end        
      def call        
        client_id = Rails.application.credentials[Rails.env.to_sym][:FACEBOOK_CLIENT_ID]
        client_secret = Rails.application.credentials[Rails.env.to_sym][:FACEBOOK_CLIENT_SECRET]        
        me = FbGraph2::User.me(@access_token)
        
        service_profile = me.fetch(fields: 'id,email,name,link')
        service = Service.where(slug: ServicePlatforms::Constants::FACEBOOK_PROFILE_SLUG).first
        service_platform = ServicePlatform.where(slug: ServicePlatforms::Constants::FACEBOOK_SLUG).first
        profile = Profile.where(
          service_id: service.id, 
          service_user_id: service_profile.id,          
          store_id: @store_id
        ).first_or_create
        profile.name = service_profile.name
        profile.access_token = service_profile.access_token          
        profile.url = service_profile.link
        profile.avatar_url = service_profile.picture.url
        profile.service_slug = service.slug
        profile.service_platform = service_platform
        profile.is_token_expired = false
        profile.save
        return profile.id
      end
    end
  end
end

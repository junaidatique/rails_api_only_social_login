module ServicePlatforms
  module Facebook
    class GetGroups
      def initialize access_token, store_id
        @access_token = access_token        
        @store_id   = store_id
      end        
      def call        
        client_id = Rails.application.credentials[Rails.env.to_sym][:FACEBOOK_CLIENT_ID]
        client_secret = Rails.application.credentials[Rails.env.to_sym][:FACEBOOK_CLIENT_SECRET]        
        me = FbGraph2::User.me(@access_token)
        
        groups = me.groups
        service = Service.where(slug: 'facebook_group').first
        service_platform = ServicePlatform.where(slug: ServicePlatforms::Constants::FACEBOOK_SLUG).first
        groups.each do |group|
          profile = Profile.where(
            service_id: service.id, 
            service_user_id: group.id,             
            store_id: @store_id
          ).first_or_create
          profile.name = group.name
          profile.access_token = group.access_token          
          profile.url = "#{ServicePlatforms::Facebook::Constants::WEB_URL}#{group.id}"
          profile.avatar_url = nil
          profile.service_slug = service.slug
          profile.service_platform = service_platform
          profile.is_token_expired = false
          profile.save
          
        end
      end
    end
  end
end

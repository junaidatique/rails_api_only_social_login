module ServicePlatforms
  module Facebook
    class GetPages
      def initialize access_token, store_id
        @access_token = access_token        
        @store_id   = store_id
      end        
      def call        
        client_id = Rails.application.credentials[Rails.env.to_sym][:FACEBOOK_CLIENT_ID]
        client_secret = Rails.application.credentials[Rails.env.to_sym][:FACEBOOK_CLIENT_SECRET]        
        me = FbGraph2::User.me(@access_token)
        
        pages = me.accounts(fields: 'id,name,access_token,link')
        service = Service.where(slug: 'facebook_page').first
        service_platform = ServicePlatform.where(slug: ServicePlatforms::Constants::FACEBOOK_SLUG).first
        pages.each do |page|
          profile = Profile.where(
            service_id: service.id, 
            service_user_id: page.id,             
            store_id: @store_id
          ).first_or_create
          profile.name = page.name
          profile.access_token = page.access_token          
          profile.url = page.link
          profile.avatar_url = page.picture.url
          profile.service_slug = service.slug
          profile.service_platform = service_platform
          profile.is_token_expired = false
          profile.save
          
        end
      end
    end
  end
end

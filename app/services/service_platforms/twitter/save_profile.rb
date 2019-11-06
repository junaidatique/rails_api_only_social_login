module ServicePlatforms
  module Twitter
    class SaveProfile
      def initialize store_id, access_token_values
        @store_id   = store_id
        @access_token_values = access_token_values
      end        
      def call        
        service_profile = ServicePlatforms::Twitter::GetAccessToken.new(@access_token_values.token, @access_token_values.secret).call
        # profile = access_token.get('account/verify_credentials')
        # puts profile.inspect        
        service = Service.where(slug: ServicePlatforms::Constants::TWITTER_PROFILE_SLUG).first
        service_platform = ServicePlatform.where(slug: ServicePlatforms::Constants::TWITTER_SLUG).first
        profile = Profile.where(
          service_id: service.id, 
          service_user_id: service_profile.user_id,          
          store_id: @store_id
        ).first_or_create
        profile.name = service_profile.screen_name
        profile.access_token = @access_token_values.token
        profile.access_token_secret = @access_token_values.secret
        profile.url = "#{ServicePlatforms::Twitter::Constants::WEB_URL}#{service_profile.screen_name}"
        # profile.avatar_url = service_profile.picture.url
        profile.service_slug = service.slug
        profile.service_platform = service_platform
        profile.is_token_expired = false
        profile.save
        return profile.id
      end
    end
  end
end

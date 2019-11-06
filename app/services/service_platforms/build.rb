module ServicePlatforms
  class Build
    def initialize(service_platform_slug)
      @service_platform_slug = service_platform_slug
    end

    def call      
      if @service_platform_slug == ServicePlatforms::Constants::FACEBOOK_SLUG      
        redirect_url = ServicePlatforms::Facebook
      elsif @service_platform_slug == ServicePlatforms::Constants::BUFFER_SLUG            
        redirect_url = ServicePlatforms::BufferProfiles
      elsif @service_platform_slug == ServicePlatforms::Constants::TWITTER_SLUG
        redirect_url = ServicePlatforms::Twitter
      end    
    end
    
  end  
end
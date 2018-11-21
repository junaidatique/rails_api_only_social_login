module ServicePlatforms
  class Build    
    def call service_platform_slug
      case service_platform_slug
      when ServicePlatforms::Constants::FACEBOOK_SLUG
        ServicePlatforms::Facebook::Init.new.call        
      end      
    end
  end  
end
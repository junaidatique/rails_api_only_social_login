module ServicePlatforms
  module Facebook
    class CheckGrantedScopes
      def initialize granted_scopes
        @granted_scopes = granted_scopes
      end        
      def call        
        if @granted_scopes.blank? 
          raise(ServicePlatforms::ExceptionHandler::InvalidGrants, ServicePlatforms::Facebook::Constants::SCOPE)    
        end
        not_permited = (ServicePlatforms::Facebook::Constants::SCOPE.split(',') - @granted_scopes.split(','))
        if not_permited.count > 0
          raise(ServicePlatforms::ExceptionHandler::InvalidGrants, not_permited.join(','))
        end
      end
    end
  end
end

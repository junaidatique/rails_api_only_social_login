module ServicePlatforms
  module ExceptionHandler
    extend ActiveSupport::Concern
    class InvalidGrants < StandardError; end
    class InvalidToken < StandardError; end
    
  end
end
module JWTAuth
  class ResetPassword
    def initialize(attributes)      
      @attributes = attributes      
    end

    # Service entry point
    def call      
      user
    end

    private

    attr_reader :attributes

    # verify user credentials
    def user
      user = User.reset_password_by_token(attributes)      
      return user if user.errors.blank?

      raise(Mongoid::Errors::Validations, user)     
    end
  end
end
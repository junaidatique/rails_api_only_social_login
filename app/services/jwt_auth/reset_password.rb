module JWTAuth
  class ResetPassword
    def initialize(email)
      @email = email      
    end

    # Service entry point
    def call
      if user.present?        
        user.send_reset_password_instructions
      end
    end

    private

    attr_reader :email

    # verify user credentials
    def user
      user = User.where(email: email).first
      return user if user      
    end
  end
end
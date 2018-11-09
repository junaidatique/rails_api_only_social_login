module JWTAuth
  class ResetPassword
    def initialize(email)
      @email = email      
    end

    # Service entry point
    def call
      if user.present?
        puts user.inspect
        user.send_reset_password_instructions
      end
    end

    private

    attr_reader :email

    # verify user credentials
    def user
      user = User.where(email: email).first
      return user if user
      # raise Authentication error if credentials are invalid
      # raise(JWTAuth::ExceptionHandler::AuthenticationError, Message.invalid_credentials)
    end
  end
end
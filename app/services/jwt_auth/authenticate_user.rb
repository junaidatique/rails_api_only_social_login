module JWTAuth
  class AuthenticateUser
    def initialize(email, password)
      @email = email
      @password = password
    end

    # Service entry point
    def call
      JWTAuth::JsonWebToken.encode(user_id: user.id) if user
    end

    private

    attr_reader :email, :password

    # verify user credentials
    def user
      user = User.where(email: email).first
      return user if user && user&.valid_password?(password)
      # raise Authentication error if credentials are invalid
      raise(JWTAuth::ExceptionHandler::AuthenticationError, Message.invalid_credentials)
    end
  end
end
class Api::V1::PasswordsController < ApiController
  skip_before_action :authorize_request, only: :edit
  def edit
    JWTAuth::ResetPassword.new(auth_params[:email]).call    
    json_response({ message: "If the email address you entered exist in our system, you will receive an email from us with a link to reset your password." })
  end
  private

  def auth_params
    params.permit(:email)
  end
end

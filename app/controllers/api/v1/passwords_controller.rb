class Api::V1::PasswordsController < ApiController
  skip_before_action :authorize_request, only: [:create, :update]
  def create
    JWTAuth::SendResetPasswordEmail.new(auth_params[:email]).call    
    json_response({ message: "If the email address you entered exist in our system, you will receive an email from us with a link to reset your password." })
  end
  def update    
    JWTAuth::ResetPassword.new(reset_password_parms).call        
    json_response({ message: "Password updated successfully." })
  end
  private

  def auth_params
    params.permit(:email)
  end
  def reset_password_parms
    params.permit(:reset_password_token, :password, :password_confirmation)
  end
end

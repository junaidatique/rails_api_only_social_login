class Api::V1::RegistrationsController < ApiController
  skip_before_action :authorize_request, only: :create
  def create
    user_params[:role] = :customer
    user = User.create!(user_params)
    @auth_token = JWTAuth::AuthenticateUser.new(user.email, user.password).call    
    decoded_auth_token ||= JWTAuth::JsonWebToken.decode(@auth_token)
    @current_user = User.find(decoded_auth_token[:user_id])    
    render 'api/v1/users/user', status: :ok
  end
  private

  def user_params
    params.permit(
      :name,
      :email,
      :password,
      :password_confirmation
    )
  end
end
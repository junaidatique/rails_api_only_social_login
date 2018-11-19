class Api::V1::SessionsController < ApiController
  skip_before_action :authorize_request, only: :create
  def create    
    @auth_token = JWTAuth::AuthenticateUser.new(auth_params[:email], auth_params[:password]).call    
    # json_response({auth_token: @auth_token})
    decoded_auth_token ||= JWTAuth::JsonWebToken.decode(@auth_token)
    @current_user = User.find(decoded_auth_token[:user_id])    
    render 'api/v1/users/user', status: :ok
  end

  private
  def auth_params
    params.permit(:email, :password)
  end
  
end

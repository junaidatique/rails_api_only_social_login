class Api::V1::SessionsController < ApiController
  skip_before_action :authorize_request, only: :create
  def create    
    @auth_token = JWTAuth::AuthenticateUser.new(auth_params[:email], auth_params[:password]).call        
    @current_user = User.find_by_jwt @auth_token
    render 'api/v1/users/user', status: :ok
  end

  private
  def auth_params
    params.permit(:email, :password)
  end
  
end

class Api::V1::SessionsController < ApiController
  skip_before_action :authorize_request, only: :create
  def create    
    auth_token = JWTAuth::AuthenticateUser.new(auth_params[:email], auth_params[:password]).call    
    json_response(auth_token: auth_token)
  end
  def show
    render 'user'
  end
  def destroy
    sign_out(current_user)
    @message = 'User has been logged out successfully.'
    render 'message', :status => :ok
  end

  private

  def auth_params
    params.permit(:email, :password)
  end
  
end

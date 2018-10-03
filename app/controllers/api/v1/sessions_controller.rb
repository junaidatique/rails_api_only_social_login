class Api::V1::SessionsController < ApiController
  
  def create
    user = User.where(email: user_params[:email]).first
    return invalid_login_attempt unless user
    if user&.valid_password?(user_params[:password])
      sign_in(:user, user)
      render 'user'
    else
      return invalid_login_attempt
    end
  end
  def show
    render 'user'
  end
  def destroy
    sign_out(current_user)
    @message = 'User has been logged out successfully.'
    render 'message', :status => :ok
  end
end

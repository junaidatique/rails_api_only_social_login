class Api::V1::UsersController < ApiController
  before_action :authenticate_user!, except:[:log_in, :sign_up]
  def log_in
    user = User.find(email: user_params[:email])
    return invalid_login_attempt unless user
    if user.valid_password?(user_params[:password])
      sign_in(:user, user)
      render 'user'
    else
      return invalid_login_attempt
    end
  end
  def show
    render 'user'
  end
  def log_out
    sign_out(current_user)
    @message = 'User has been logged out successfully.'
    render 'message', :status => :ok
  end
end

class Api::V1::UsersController < ApiController
  def show
    puts @current_user.inspect
    # json_response(@current_user)
    render 'user'
  end
end

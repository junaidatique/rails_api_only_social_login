class Api::V1::UsersController < ApiController
  def show    
    render 'user', status: :ok
  end
end

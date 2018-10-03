class Api::V1::UsersController < ApiController
  before_action :authenticate_user!
  
end

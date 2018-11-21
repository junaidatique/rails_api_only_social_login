class ApiController < ApplicationController
  include ActionView::Rendering

  include Response
  include ExceptionHandler

  # called before every action on controllers
  before_action :authorize_request
  attr_reader :current_user

  private

  # Check for valid request token and return user
  def authorize_request
    if controller_name == 'oauth' and action_name == 'autherize' and params[:state].present?
      request.headers['Authorization'] = params[:state]
    end
    @current_user = (JWTAuth::AuthorizeApiRequest.new(request.headers).call)[:user]
  end
end
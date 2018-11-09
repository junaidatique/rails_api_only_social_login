module JWTAuth::ExceptionHandler
  extend ActiveSupport::Concern

  # Define custom error subclasses - rescue catches `StandardErrors`
  class AuthenticationError < StandardError; end
  class MissingToken < StandardError; end
  class InvalidToken < StandardError; end

  included do
    # Define custom handlers
    rescue_from JWTAuth::ExceptionHandler::AuthenticationError, with: :unauthorized_request
    rescue_from Mongoid::Errors::InvalidValue, with: :four_twenty_two    
    rescue_from JWTAuth::ExceptionHandler::MissingToken, with: :four_twenty_two
    rescue_from JWTAuth::ExceptionHandler::InvalidToken, with: :four_twenty_two

    rescue_from Mongoid::Errors::DocumentNotFound do |e|
      json_response({ message: e.message }, :not_found)
    end
  end

  private

  # JSON response with message; Status code 422 - unprocessable entity
  def four_twenty_two(e)
    json_response({ message: e.message }, :unprocessable_entity)
  end

  # JSON response with message; Status code 401 - Unauthorized
  def unauthorized_request(e)
    json_response({ message: e.message }, :unauthorized)
  end
end
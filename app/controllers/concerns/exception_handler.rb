module ExceptionHandler  
  extend ActiveSupport::Concern

  included do
    rescue_from JWTAuth::ExceptionHandler::MissingToken do |e|
      json_response({ message: e.message }, :not_found)
    end

    rescue_from Mongoid::Errors::DocumentNotFound do |e|
      json_response({ message: e.message }, :unprocessable_entity)
    end
    rescue_from Mongoid::Errors::Validations do |e|
      json_response({ message: e.message }, :unprocessable_entity)
    end
    rescue_from JWTAuth::ExceptionHandler::AuthenticationError do |e|
      json_response({ message: e.message }, :not_found)
    end
  end
end
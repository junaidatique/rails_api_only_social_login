module ExceptionHandler  
  extend ActiveSupport::Concern

  included do
    rescue_from JWTAuth::ExceptionHandler::MissingToken do |e|
      json_response({ message: e.message }, :not_found)
    end
    rescue_from JWTAuth::ExceptionHandler::InvalidToken do |e|
      json_response({ message: e.message }, :unprocessable_entity)
    end
    rescue_from JWTAuth::ExceptionHandler::AuthenticationError do |e|
      json_response({ message: e.message }, :not_found)
    end
    rescue_from Mongoid::Errors::DocumentNotFound do |e|
      json_response({ message: e.message }, :unprocessable_entity)
    end
    rescue_from Mongoid::Errors::Validations do |e|
      json_response({ message: e.message }, :unprocessable_entity)
    end
    rescue_from FbGraph2::Exception::BadRequest do |e|
      json_response({ message: e.message }, :unprocessable_entity)
    end
    rescue_from ServicePlatforms::ExceptionHandler::InvalidToken do |e|
      json_response({ message: e.message }, :unprocessable_entity)
    end
    rescue_from ServicePlatforms::ExceptionHandler::InvalidGrants do |e|      
      state = params[:state]
      ungranted_scope = e.message
      redirect_url = ServicePlatforms::Facebook::RerequestUri.new(state, ungranted_scope).call
      json_response({ redirect_url: redirect_url }, :not_acceptable)
    end
    rescue_from ShopifyAPI::ValidationException do |e|
      json_response({ message: e.message }, :not_acceptable)
    end
    rescue_from OAuth::Unauthorized do |e|
      json_response({ message: e.message }, :unprocessable_entity)
    end
  end
end
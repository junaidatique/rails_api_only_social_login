class Api::V1::OauthController < ApiController
  def redirect
    payload = Hash.new
    payload[:user_id] = @current_user.id    
    payload[:store_id] = platform_params[:store_id]
    if platform_params[:service_platform] == Constants::ServicePlatformsConstants::FACEBOOK_SLUG
      client  = ServicePlatforms::Facebook::Init.new.call
      scope   = ServicePlatforms::Facebook::Constnt::SCOPE      
    end    
    payload[:service_platform] = platform_params[:service_platform]
    state = JWTAuth::JsonWebToken.encode(payload)
    redirect_url = ServicePlatforms::Auth::AuthorizationUri.new(client,state,scope).call
    json_response({redirect_url: redirect_url})
  end
  
  private
  def platform_params
    params.permit(
      :service_platform,
      :store_id
    )
  end
end

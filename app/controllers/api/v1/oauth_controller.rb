class Api::V1::OauthController < ApiController
  def redirect
    payload = Hash.new    
    payload[:store_id] = platform_params[:store_id]
    payload[:service_platform] = platform_params[:service_platform]
    
    redirect_url = nil
    service_platform_object = ServicePlatforms::Build.new(platform_params[:service_platform]).call
    redirect_url = service_platform_object::AuthorizationUri.new(@current_user, payload).call    
    json_response({redirect_url: redirect_url})
  end
  def autherize
    code = response_params[:code]
    state = response_params[:state]    
    token_values = JWTAuth::JsonWebToken.decode(state)
    
    @current_user = User.find_by_jwt state
    if @current_user.blank?
      render json: 'Invalid Token', status: :unprocessable_entity
    else
      service_platform_object = ServicePlatforms::Build.new(platform_params[:service_platform]).call
      service_platform_object::HandleOauthResponse.new(response_params).call
      
      @store = Store.find(token_values[:store_id])
      @service_platform = ServicePlatform.where(slug: response_params[:service_platform]).first
      @is_connected = false      
    end
  end
  private
  def response_params
    params.permit(
      :granted_scopes,
      :denied_scopes,
      :code,
      :state,
      :service_platform,
      :oauth_verifier
    )
  end
  def platform_params
    params.permit(
      :service_platform,
      :store_id
    )
  end
end

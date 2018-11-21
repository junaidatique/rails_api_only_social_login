class Api::V1::OauthController < ApiController
  def redirect
    payload = Hash.new    
    payload[:store_id] = platform_params[:store_id]
    payload[:service_platform] = platform_params[:service_platform]
    state = @current_user.get_jwt(payload)
    redirect_url = nil
    
    if platform_params[:service_platform] == ServicePlatforms::Constants::FACEBOOK_SLUG      
      redirect_url = ServicePlatforms::Facebook::AuthorizationUri.new(state).call
    elsif platform_params[:service_platform] == ServicePlatforms::Constants::BUFFER_SLUG
      client  = ServicePlatforms::Buffer::Init.new.call
      scope   = ServicePlatforms::Buffer::Constants::SCOPE
      response_type = ServicePlatforms::Buffer::Constants::RESPONSE_TYPE
    end
    
    
    
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
      puts @current_user.inspect
      puts response_params.inspect
      if response_params[:service_platform] == ServicePlatforms::Constants::FACEBOOK_SLUG
        ServicePlatforms::Facebook::HandleOauthResponse.new(response_params).call
      elsif response_params[:service_platform] == ServicePlatforms::Constants::BUFFER_SLUG      
        ServicePlatforms::Auth::GetAccessToken.new(code).call.inspect
      end
      @store = Store.find(token_values[:store_id])
      @service_platform = ServicePlatform.where(slug: response_params[:service_platform]).first
      @is_connected = false
      # render 'api/v1/profiles/profiles'
    end
  end
  private
  def response_params
    params.permit(
      :granted_scopes,
      :denied_scopes,
      :code,
      :state,
      :service_platform
    )
  end
  def platform_params
    params.permit(
      :service_platform,
      :store_id
    )
  end
end

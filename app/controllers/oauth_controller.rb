class OauthController < ApplicationController
  
  def autherize
    # puts response_params[:code].inspect
    # puts response_params[:state].inspect
    # puts JWTAuth::JsonWebToken.decode(response_params[:state]).inspect

    # puts response_params.inspect
    if response_params[:service_platform] == Constants::ServicePlatformsConstants::FACEBOOK_SLUG
      puts ServicePlatforms::Auth::GetAccessToken.new(response_params[:code], ServicePlatforms::Facebook::Init.new.call).call.inspect
    end
    render json: '', status: status
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
end

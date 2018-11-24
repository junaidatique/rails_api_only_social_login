class Api::V1::PartnersController < ApiController
  skip_before_action :authorize_request
  def signup    
    jwt_token = JWTAuth::JsonWebToken.encode(
      {
        shop: signup_params[:shop], 
        user_id: signup_params[:user_id]
      }
    )
    partner = Partners::Build.new(signup_params[:partner_platform]).call
    options = Hash.new
    options[:jwt_token] = jwt_token
    options[:shop]      = signup_params[:shop]
    redirect_url = partner::AuthorizationUri.new(options).call
    if signup_params[:partner_platform] == Partners::Constants::SHOPIFY_SLUG
      
    end    
    json_response({redirect_url: redirect_url})
  end
  def autherize    
    jwt_token = JWTAuth::JsonWebToken.decode(autherize_params[:state])
    partner   = Partners::Build.new(signup_params[:partner_platform]).call
    response  = partner::HandleOauth.new(jwt_token,autherize_params).call
    
  end

  private

  def signup_params
    params.permit(
      :partner_platform,
      :shop,
      :user_id
    )
  end
  def autherize_params
    params.permit(
      :partner_platform,
      :code,
      :shop,      
      :state,
      :timestamp,
      :hmac
    )
  end
  
  
end

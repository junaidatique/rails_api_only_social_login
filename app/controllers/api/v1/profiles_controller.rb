class Api::V1::ProfilesController < ApiController
  before_action :set_store
  def index
    
  end
  def connected
    
  end
  def connect    
    @store.profiles.in(id: profile_params[:ids]).update_all({is_connected: true})
    render 'api/v1/profiles/connected'
  end
  def disconnect
    @store.profiles.in(id: profile_disconnect_params[:id]).update({is_connected: false})
    render 'api/v1/profiles/connected'
  end
  private
  def set_store
    @store = Store.find(params[:store_id])
  end
  def profile_params    
    params.require(:profile).permit ids: []    
  end
  def profile_disconnect_params    
    params.permit :id   
  end
  
  
end

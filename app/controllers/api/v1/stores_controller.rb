class Api::V1::StoresController < ApiController
  before_action :set_store
  def show    
    
  end

  private
  def set_store
    @store = Store.find(params[:id])
  end
  
  
end

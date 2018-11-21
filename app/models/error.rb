class Error
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user, optional: true, index: true 
  belongs_to :store, optional: true, index: true 
  belongs_to :service_platform, optional: true, index: true 
  belongs_to :profile, optional: true, index: true 
  belongs_to :update, optional: true, index: true 
end

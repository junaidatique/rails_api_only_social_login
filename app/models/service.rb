class Service
  include Mongoid::Document

  field :name, type: String
  field :slug, type: String  
  field :character_limit, type: Integer
  field :can_schedule, type: Boolean, default: true  
  
  #relationships
  belongs_to :service_platform

  has_many :profiles
  
end

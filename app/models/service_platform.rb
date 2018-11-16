class ServicePlatform
  include Mongoid::Document

  field :name, type: String
  field :url, type: String  
  field :share_options, type: Hash
  #relationships
  has_many :services
end
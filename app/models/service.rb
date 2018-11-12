class Service
  include Mongoid::Document

  field :name, type: String

  #relationships
  has_many :profiles
end

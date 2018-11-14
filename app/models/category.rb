class Category
  include Mongoid::Document
  include Mongoid::Timestamps

  include Partnerable

  
  
  belongs_to :store
  has_and_belongs_to_many :products
  has_and_belongs_to_many :rules
  
end

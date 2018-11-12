class Category
  include Mongoid::Document


  belongs_to :store
  has_and_belongs_to_many :products
  has_and_belongs_to_many :rules
  
end

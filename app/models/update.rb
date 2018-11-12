class Update
  include Mongoid::Document


  belongs_to :store, index: true 
  belongs_to :profile, index: true 
  belongs_to :rule, optional: true, index: true 
  belongs_to :product, optional: true, index: true 
  
  embeds_many :images, as: :imageable, class_name: Image.name, cascade_callbacks: true
end

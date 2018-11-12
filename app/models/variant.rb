class Variant
  include Mongoid::Document
  
  field :title, type: String

  embedded_in :products
  embeds_many :images, as: :imageable, class_name: Image.name, cascade_callbacks: true
end

class Caption
  include Mongoid::Document
  
  field :description, type: String
  field :is_default, type: Boolean
  field :start_time, type: Time
  field :end_time, type: Time

  embedded_in :products
  embeds_many :images, as: :imageable, class_name: Image.name, cascade_callbacks: true
end

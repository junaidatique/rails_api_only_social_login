class Product
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :description, type: String
  field :quantity, type: Integer
  field :is_unlimited, type: Boolean

  belongs_to :store, index: true 
  has_and_belongs_to_many :categories
  embeds_many :images, as: :imageable, class_name: Image.name, cascade_callbacks: true
  embeds_many :variants
  has_many :updates
end

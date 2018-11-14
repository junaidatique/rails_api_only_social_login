class Variant
  include Mongoid::Document
  include Mongoid::Timestamps
  include Partnerable

  field :price, type: Float
  field :original_price, type: Float
  field :on_sale, type: Boolean, default: false
  field :quantity, type: Integer
  field :postable_by_quantity, type: Boolean
  field :postable_by_price, type: Boolean
  field :postable_is_new, type: Boolean


  index({ postable_by_quantity: 1 }, { name: "postable_by_quantity_index" })  
  index({ postable_by_price: 1 }, { name: "postable_by_price_index" })  
  index({ postable_is_new: 1 }, { name: "postable_is_new_index" })  

  embedded_in :products
  embeds_many :images, as: :imageable, class_name: Image.name, cascade_callbacks: true

  before_save :check_values

  def check_values
    if quantity > 0
      postable_by_quantity = true
    end
    if price > 0
      postable_by_price = true
    end
  end
end

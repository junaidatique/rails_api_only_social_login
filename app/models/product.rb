class Product
  include Mongoid::Document
  include Mongoid::Timestamps
  include Partnerable
  
  field :quantity, type: Integer  
  field :minimum_price, type: Float
  field :maximum_price, type: Float
  field :on_sale, type: Boolean, default: false
  field :short_url, type: String
  field :postable_by_quantity, type: Boolean
  field :postable_by_price, type: Boolean
  field :postable_is_new, type: Boolean


  index({ postable_by_quantity: 1 }, { name: "postable_by_quantity_index" })  
  index({ postable_by_price: 1 }, { name: "postable_by_price_index" })  
  index({ postable_is_new: 1 }, { name: "postable_is_new_index" })  


  belongs_to :store, index: true 
  has_and_belongs_to_many :categories
  has_many :updates, as: :shareable, class_name: Update.name
  has_many :images
  has_many :variants
  has_many :updates

  before_save :check_values

  def check_values
    if quantity > 0 or is_unlimited
      postable_by_quantity = true
    end
    if minimum_price > 0
      postable_by_price = true
    end
  end

end

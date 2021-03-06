class Store
  include Mongoid::Document
  include Mongoid::Timestamps
  include SimpleEnum::Mongoid
  include Mongoid::Timestamps
  include Partnerable
  
  as_enum :status, installed: 0, charged: 1, uninstalled: 2

  
  field :partner_token, type: String
  field :timezone, type: String
  field :currency, type: String
  field :money_format, type: String
  field :money_with_currency_format, type: String
  field :number_of_products, type: Integer, default: 0
  field :no_of_active_products, type: Integer, default: 0
  field :number_of_scheduled_posts, type: Integer, default: 0
  field :number_of_posted, type: Integer, default: 0
  field :products_last_updated, type: Time
  


  # relationships  
  belongs_to :user, index: true, touch: true, counter_cache: :number_of_stores
  embeds_one :address, as: :addressable, class_name: Address.name, cascade_callbacks: true, autobuild: true


  has_many :profiles
  has_many :products
  has_many :categories
  has_many :updates

end

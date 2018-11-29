class Image
  include Mongoid::Document
  include Mongoid::Timestamps
  
  include Partnerable
  
  field :thumbnail_url, type: String
  
  belongs_to :product
end

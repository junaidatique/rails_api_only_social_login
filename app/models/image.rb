class Image
  include Mongoid::Document
  include Mongoid::Timestamps
  
  include Partnerable
  
  embedded_in :imageable, polymorphic: true
end

class Image
  include Mongoid::Document
  
  field :external_url, type: String
  
  embedded_in :imageable, polymorphic: true
end

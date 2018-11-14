class Address
  include Mongoid::Document
  include Mongoid::Geospatial
  
  field :address1, type: String
  field :address2, type: String
  field :zip_code, type: String
  field :city, type: String
  field :phone, type: String
  field :province, type: String
  field :province_code, type: String
  field :country_name, type: String
  field :country_code, type: String
  field :location, type: Point, spatial: true
  field :primary_locale, type: String
  spatial_index :location
  
  embedded_in :addressable, polymorphic: true
end

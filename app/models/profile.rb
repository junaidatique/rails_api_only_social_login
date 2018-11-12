class Profile
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :avatar_url, type: String
  field :service_user_id, type: String
  field :service_username, type: String
  field :formatted_username, type: String
  field :url, type: String
  field :access_token, type: String
  field :access_token_secret, type: String

  field :buffer_id, type: String

  field :is_connected, type: Boolean, default: false
  field :is_token_expired, type: Boolean, default: false
   
  #relationships
  belongs_to :store
  belongs_to :service
  belongs_to :parent_profile

  has_many :child_profiles
  
end

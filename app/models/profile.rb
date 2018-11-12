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
  belongs_to :store, index: true 
  belongs_to :service, index: true 
  belongs_to :parent_profile, index: true 

  has_many :child_profiles
  has_many :updates
  has_and_belongs_to_many :rules, inverse_of: :selected_profiles
end

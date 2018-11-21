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
  field :service_slug, type: String

  field :buffer_id, type: String

  field :is_connected, type: Boolean, default: false
  field :is_token_expired, type: Boolean, default: false
   
  #validations
  validates :name, :service_user_id, :service_slug, :access_token, presence: true
  #indexes
  index({ service_user_id: 1 }, { name: "service_user_id_index" })

  #relationships
  belongs_to :store, index: true 
  belongs_to :service, index: true 
  belongs_to :service_platform, index: true 
  belongs_to :parent_profile, index: true, optional: true, class_name: Profile.name, inverse_of: :child_profiles

  has_many :child_profiles, class_name: Profile.name, inverse_of: :parent_profile
  has_many :updates
  has_and_belongs_to_many :rules, inverse_of: :selected_profiles

  #scopes 
  scope :facebook_profile, -> { where(service_slug: 'facebook_profile') }
  scope :buffer_profile, -> { where(service_slug: 'buffer') }
  scope :connected, -> { where(is_connected: true) }
end

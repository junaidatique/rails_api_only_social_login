class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include SimpleEnum::Mongoid
  # include Mongoid::History::Trackable

  # track_history   :on => [:fields]

  as_enum :role, %i{admin customer }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  # Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time


  field :name, type: String
  field :number_of_stores, type: Integer, default: 0
  # relationships
  has_many :stores

  before_save :caculate_no_of_stores

  def caculate_no_of_stores    
    number_of_stores = self.stores.published.count if number_of_stores_changed?
  end
  
  def self.find_by_jwt auth_token
    decoded_auth_token ||= JWTAuth::JsonWebToken.decode(auth_token)
    User.find(decoded_auth_token[:user_id])    
  end
  
  def get_jwt(payload = {})
    payload[:user_id] = self.id.to_s
    JWTAuth::JsonWebToken.encode(payload)
  end
  
  
end

class Update
  include Mongoid::Document

  field :profile_platform, type: String
  field :caption, type: String
  field :utc_schedule_time, type: Time
  field :user_schedule_time, type: Time
  field :formatted_utc_schedule_time, type: String
  field :formatted_user_schedule_time, type: String
  field :scheduled_at, type: Time

  belongs_to :store, index: true 
  belongs_to :profile, index: true 
  belongs_to :rule, optional: true, index: true 
  belongs_to :shareable, polymorphic: true, optional: true

  embeds_many :images, as: :imageable, class_name: Image.name, cascade_callbacks: true
end

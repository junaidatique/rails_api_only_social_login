class Rule
  include Mongoid::Document

  field :formatted_title, type: String  

  

  belongs_to :service
  belongs_to :store

  has_many :updates
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :selected_profiles, class_name: Profile.name
end

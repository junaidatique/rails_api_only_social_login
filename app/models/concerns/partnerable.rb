module Partnerable
  extend ActiveSupport::Concern
  included do    
    field :title, type: String
    field :slug, type: String 
    field :url, type: String 
    field :partner_id, type: String
    field :partner_name, type: String
    field :partner_specific_url, type: String
    field :partner_created_at, type: String
    field :partner_updated_at, type: String
    field :uniq_key, type: String
    field :description, type: String
    field :position, type: Integer
    field :is_published, type: Boolean

    # validates :partner_id, :partner_name , presence: true

    scope :un_published, -> { where(is_published: false) }
    scope :published, -> { where(is_published: true) }

    index({ uniq_key: 1 }, { unique: true, name: "uniq_key_index" })
    index({ partner_id: 1 }, { name: "partner_id_index" })  
    index({ is_published: 1 }, { name: "is_published_index" })  
  end

  def publish!    
    self.update_attribute :is_published, true
  end
  def un_publish!    
    self.update_attribute :is_published, false
  end
  def published?    
    self.is_published
  end
end
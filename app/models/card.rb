class Card < ActiveRecord::Base
  belongs_to :seller
  has_many :features
  has_many :coordinates
  has_many :locations
  has_many :media
  has_many :contacts


  def modified_recently
    return false if self.new_record?
    self.updated_at >= 1.hours.ago || self.created_at >= 1.hours.ago
  end

  def get_feature_value(name)
    feature = self.features.find_by(feature: name)
    feature.value unless feature.nil?
  end
end

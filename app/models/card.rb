class Card < ActiveRecord::Base
  belongs_to :seller
  has_many :features
  has_many :coordinates
  has_many :locations
  has_many :media
  has_many :contacts
end

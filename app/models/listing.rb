class Listing < ActiveRecord::Base
  validates :title, presence: true
  validates :description, presence: true

  belongs_to :user
  has_many :bookings
  has_many :listing_tags
  has_many :tags, :through => :listing_tags
end

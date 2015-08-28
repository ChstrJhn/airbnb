class Tag < ActiveRecord::Base
  validates :category, presence: true

  has_many :listing_tags
  has_many :listings, :through  => :listing_tags
end

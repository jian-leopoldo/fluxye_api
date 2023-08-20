class CommunityGroup < ApplicationRecord
  belongs_to :user
  has_many :communities
end

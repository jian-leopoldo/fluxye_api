class Community < ApplicationRecord
  extend FriendlyId

  belongs_to :community_group
  friendly_id :name, use: :slugged
end

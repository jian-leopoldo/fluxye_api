class Community < ApplicationRecord
  extend FriendlyId

  belongs_to :user
  friendly_id :name, use: :slugged
  has_many :channels
end

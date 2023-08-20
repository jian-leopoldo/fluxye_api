class User < ApplicationRecord
  has_secure_password
  has_many :community_groups
  has_many :communities, :through => :community_groups, :source => CommunityGroup

  scope :by_roles, -> (roles) { roles ? where("roles @> ?", "{#{roles.join(",")}}") : all }

  def master?
    roles.include?('master')
  end

end

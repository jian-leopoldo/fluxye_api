class User < ApplicationRecord
  has_secure_password
  has_many :communities

  scope :by_roles, -> (roles) { roles ? where("roles @> ?", "{#{roles.join(",")}}") : all }

  def master?
    roles.include?('master')
  end

end

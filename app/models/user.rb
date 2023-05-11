class User < ApplicationRecord
  has_secure_password

  scope :one_of, -> (roles) { roles ? where("roles @> ARRAY[?]::varchar[]", roles) : all }

end

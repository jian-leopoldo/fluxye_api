class UserSerializer
  include JSONAPI::Serializer

  attributes :name, :email, :phone, :roles
end

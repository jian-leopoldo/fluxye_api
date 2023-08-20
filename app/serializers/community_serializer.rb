class CommunitySerializer
  include JSONAPI::Serializer

  attributes :name, :description, :slug, :id
end

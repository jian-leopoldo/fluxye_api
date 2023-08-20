class CommunityGroupSerializer
  include JSONAPI::Serializer

  attributes :name, :description
end

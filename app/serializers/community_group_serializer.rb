class CommunityGroupSerializer
  include JSONAPI::Serializer

  attributes :name, :description, :communities
end

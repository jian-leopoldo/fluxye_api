class CommunityGroups::Update
  include Dry::Transaction

  try :find, catch: ActiveRecord::RecordNotFound
  step :validate
  step :persist

  private

  def find(current_user:, id:, input:)
    community_group = current_user.community_groups.find(id)
    { community_groups: community_group, input: input }
  end

  def validate(community_groups:, input:)
    community_groups.assign_attributes(input)
    if community_groups.valid?
      Success(community_groups)
    else
      Failure(community_groups.errors)
    end
  end

  def persist(community_groups)
    community_groups.save
    Success(community_groups)
  end
end

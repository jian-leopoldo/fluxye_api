class Community::Update
  include Dry::Transaction

  try :find_community_group, catch: ActiveRecord::RecordNotFound
  try :find, catch: ActiveRecord::RecordNotFound
  step :validate
  step :persist

  private

  def find_community_group(current_user:, community_group_id:, id:, input:)
    community_group = current_user.community_groups.find(community_group_id)
    { community_group: community_group, input: input, id: id}
  end

  def find(id:,community_group:, input:)
    community = community_group.communities.find(id)
    { community: community, input: input }
  end

  def validate(community:,input:)
    result = contract.call(input)
    community.assign_attributes(input)
    if result.success? && community.valid?
      Success(community)
    else
      Failure(result.errors(full: true))
    end
  end

  def persist(community)
    Success(community)
  end

  def contract
    Community::Contracts::New.new
  end
end

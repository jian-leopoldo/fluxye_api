class CommunityGroups::Create
  include Dry::Transaction

  step :validate
  step :persist

  private

  def validate(input)
    debugger
    result = CommunityGroups::Contracts::NewCommunityGroup.new.call(input)
    if result.success?
      Success(CommunityGroup.create(result.values))
    else
      Failure(result.errors(full: true))
    end
  end

  def persist(community_group)
    Success(community_group)
  end
end

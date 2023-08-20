class Community::Update
  include Dry::Transaction

  try :find, catch: ActiveRecord::RecordNotFound
  step :validate
  step :persist

  private

  def find(id:,current_user:, input:)
    community = current_user.communities.find(id)
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

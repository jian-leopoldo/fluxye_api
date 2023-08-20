class Community::Create
  include Dry::Transaction

  step :validate
  step :persist

  private

  def validate(input)
    result = contract.call(input)
    debugger
    if result.success?
      Success(Community.create(result.values))
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

class Channel::Create
  include Dry::Transaction

  step :validate
  step :persist

  private

  def validate(input)
    result = contract.call(input)
    debugger
    if result.success?
      Success(Channel.create(result.values))
    else
      Failure(result.errors(full: true))
    end
  end

  def persist(community)
    Success(community)
  end

  def contract
    Channel::Contracts::New.new
  end
end

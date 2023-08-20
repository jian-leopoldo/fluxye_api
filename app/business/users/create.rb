class Users::Create
  include Dry::Transaction

  step :validate
  step :persist

  private

  def validate(input)
    debugger
    result = Users::Contracts::NewUser.new.call(input)
    if result.success?
      Success(User.new(result.values))
    else
      Failure(result.errors(full: true))
    end
  end

  def persist(user)
    user.save
    Success(user)
  end
end

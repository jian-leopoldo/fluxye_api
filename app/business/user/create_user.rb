class User::CreateUser
  include Dry::Transaction

  step :validate
  step :persist

  private

  def validate(input)
    user = User.new(input)
    if user.valid?
      Success(user)
    else
      Failure(user.errors)
    end
  end

  def persist(user)
    user.save
    Success(user)
  end
end

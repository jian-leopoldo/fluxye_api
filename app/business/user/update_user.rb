class User::UpdateUser
  include Dry::Transaction

  try :find, catch: ActiveRecord::RecordNotFound
  step :validate
  step :persist

  private

  def find(input)
    user = User.find(input[:id])
    { user: user, input: input }
  end

  def validate(user:, input:)
    user.assign_attributes(input)
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

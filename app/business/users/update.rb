class Users::Update
  include Dry::Transaction

  try :find, catch: ActiveRecord::RecordNotFound
  step :validate
  step :persist

  User.where("roles @> '{#{['admin'].join(",")}}'").first
  User.where("roles @> '{?}'", "#{['admin'].join(",")}").first

  private

  def find(input:, id:)
    user = User.find(id)
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

class Users::Show
  include Dry::Transaction

  try :find, catch: ActiveRecord::RecordNotFound

  private

  def find(id:)
    user = User.find(id)
    user
  end
end

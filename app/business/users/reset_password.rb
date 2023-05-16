class Users::ResetPassword
  include Dry::Transaction

  step :find
  step :update_password

  private

  def find(params)
    user = User.find_by(id: params[:uuid], reset_password_token: params[:recover_token])
    debugger
    if user
      Success({user: user, password: params[:password]})
    else
      Failure('Invalid recover token')
    end
  end

  def update_password(user:, password:)
    if user.update(password: password, reset_password_token: nil)
      Success('Password changed')
    else
      Failure('Error when change password')
    end
  end
end
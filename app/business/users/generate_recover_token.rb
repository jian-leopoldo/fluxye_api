class Users::GenerateRecoverToken
  include Dry::Transaction

  step :find
  step :generate_recover_token

  private

  def find(params)
    user = User.find_by(email: params[:email])
    if user
      Success(user)
    else
      Failure('Invalid email')
    end
  end

  def generate_recover_token(user)
    if user.update(reset_password_token: SecureRandom.hex(10))
      Success('Reset password token generated')
    else
      Failure('Error when reset password')
    end
  end
end
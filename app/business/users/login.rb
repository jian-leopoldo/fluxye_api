class Users::Login
  include Dry::Transaction

  step :find
  step :encode

  private

  def find(params)
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      Success(user)
    else
      Failure('Invalid password')
    end
  end

  def encode(user)
    Success(JwtEncoder.encode(user_id: user.id))
  end
end
  
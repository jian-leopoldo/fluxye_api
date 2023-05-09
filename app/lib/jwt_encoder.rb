class JwtEncoder
  DEFAULT_EXP = 48.hours.from_now
  SECRET_KEY = Rails.application.secrets.secret_key_base

  def self.encode(payload, exp = DEFAULT_EXP)
    JWT.encode(payload, SECRET_KEY, 'HS256')
  end
end

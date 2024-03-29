class Users::Contracts::NewUser < Dry::Validation::Contract
  params do
    required(:name).filled(:string)
    required(:phone).filled(:string)
    required(:email).filled(:string)
    required(:password).filled(:string)
    optional(:roles).array(:str?)
  end

  rule(:roles) do
    if value.include?('master')
      key.failure('invalid role')
    end
  end

  rule(:email) do
    unless /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.match?(value)
      key.failure('has invalid format')
    end
  end
end

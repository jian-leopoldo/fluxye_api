class Community::Contracts::New < Dry::Validation::Contract
  params do
    required(:name).filled(:string)
    required(:user_id).filled(:string)
    optional(:description).filled(:string)
    optional(:primary_color).filled(:string)
    optional(:secondary_color).filled(:string)
  end

  rule(:name) do
    key.failure('invalid name') if value.length < 4
  end
end

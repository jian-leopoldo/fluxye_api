class Channel::Contracts::New < Dry::Validation::Contract
  params do
    required(:name).filled(:string)
    required(:community_id).filled(:integer)
    required(:type).filled(:string)
    optional(:description).filled(:string)
  end

  rule(:name) do
    key.failure('invalid name') if value.length < 2
  end
end

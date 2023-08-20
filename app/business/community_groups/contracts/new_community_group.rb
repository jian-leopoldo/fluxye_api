class CommunityGroups::Contracts::NewCommunityGroup < Dry::Validation::Contract
  params do
    required(:name).filled(:string)
    required(:user_id).filled(:string)
    optional(:description).filled(:string)
  end

  rule(:name) do
    key.failure('invalid name') if value.length < 4
  end
end

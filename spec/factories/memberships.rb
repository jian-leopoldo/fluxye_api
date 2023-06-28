FactoryBot.define do
  factory :membership do
    user { nil }
    community { nil }
    roles { "MyText" }
  end
end

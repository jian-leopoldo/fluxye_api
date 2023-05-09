# This will guess the User class
FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email  { Faker::Internet.email }
    phone { Faker::PhoneNumber.cell_phone }
    document { Faker::IDNumber.brazilian_citizen_number }
    password { Faker::Internet.password }
    roles { [] }

    trait :admin do
      roles { ['admin'] }
    end

    trait :master do
      roles { ['master'] }
    end

    trait :manager do
      roles { ['manager'] }
    end

  end
end

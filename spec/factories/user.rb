FactoryGirl.define do
  factory :user do
    transient do
      password nil
    end

    email              { Faker::Internet.email }
    encrypted_password { Faker::Internet.password }
    first_name         { Faker::Name.first_name }
    last_name          { Faker::Name.last_name }

    after(:build) do |user, evaluator|
      if evaluator.password.present?
        user.encrypted_password = BCrypt::Password.create(evaluator.password)
      end
    end

    trait :signed_in do
      after(:create) do |user|
        user.device_sessions << build(:device_session, user: nil)
      end
    end
  end
end

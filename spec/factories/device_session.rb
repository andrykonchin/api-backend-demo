FactoryGirl.define do
  factory :device_session do
    association :user

    authentication_token { SecureRandom.hex }
  end
end


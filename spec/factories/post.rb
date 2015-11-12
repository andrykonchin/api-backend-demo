FactoryGirl.define do
  factory :post do
    association :user

    title          { Faker::Lorem.sentence }
    body           { Faker::Lorem.paragraph }

    trait :with_video do
      video  Rack::Test::UploadedFile.new('./spec/fixtures/video-07.MOV',
                                          'video/quicktime')
    end
  end
end

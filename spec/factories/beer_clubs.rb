# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :beer_club do
    name "Test club"
    founded { Time.new.year }
    city "Helsinki"

    after(:create) do |bc, evaluator|
      create_list(:membership, 1, beer_club: bc)
    end
  end
end

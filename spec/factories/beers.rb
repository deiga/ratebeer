# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :beer do
    name "anonymous"
    brewery
    style "Lager"
  end
end

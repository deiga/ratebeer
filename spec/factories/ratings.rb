# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :rating do
    score 10
  end

  factory :rating2, class: Rating do
    score 20
  end
end

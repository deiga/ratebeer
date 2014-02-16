# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    username
    password "Foobar1"
    password_confirmation "Foobar1"
  end

  sequence :username do |n|
    "Pekka#{n}"
  end
end

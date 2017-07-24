FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email
    password 'foobar'
  end
end

FactoryGirl.define do
  sequence :email do |n|
    "#{Faker::Name.name@example.com}"
  end
end

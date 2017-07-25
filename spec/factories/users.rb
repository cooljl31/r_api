FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email
    email 'johndoe@example.com'
    password 'foobar'
  end
end

FactoryGirl.define do
  sequence :email do |n|
    "#{Faker::Name.name@example.com}"
  end
end

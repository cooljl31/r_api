FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email 'sirop@example.com'
    password 'foobar'
  end
end

#FactoryGirl.define do
  #sequence :email do |n|
    #"cooool#{n}@example.com "
  #end
#end

FactoryBot.define do
  sequence :email do |n|
    "test#{n}@test.com"
  end

  factory :user do
    email
    password              { '666666' }
    password_confirmation { '666666' }
  end
end

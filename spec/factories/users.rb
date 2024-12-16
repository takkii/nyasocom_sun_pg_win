# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "karuma.reason#{n}@gmail.com" }
    password              { "rubyist1122" }
    password_confirmation { "rubyist1122" }
  end
end

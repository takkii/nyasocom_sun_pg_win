# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "karuma.reason#{n}@gmail.com" }
    password              { "jbUuwYC-4lWO8JMFruPvePQGA" }
    password_confirmation { "jbUuwYC-4lWO8JMFruPvePQGA" }
  end
end

# spec/factories/admins.rb
FactoryBot.define do
    factory :admin do
      sequence(:email) { |n| "karuma_reason#{n}@yahoo.co.jp" }
      password              { "1122rubyist" }
      password_confirmation { "1122rubyist" }
  end
end
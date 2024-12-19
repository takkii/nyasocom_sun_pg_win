# spec/factories/admins.rb
FactoryBot.define do
    factory :admin do
      sequence(:email) { |n| "sound_gear_0830#{n}@yahoo.co.jp" }
      password              { "DQjZs!edkzrgbM$4VVte2!LZE" }
      password_confirmation { "DQjZs!edkzrgbM$4VVte2!LZE" }
  end
end
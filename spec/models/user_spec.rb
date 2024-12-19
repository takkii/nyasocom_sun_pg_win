require 'rails_helper'

describe User do
    it "has a valid factory" do
        expect(FactoryBot.build(:user)).to be_valid
    end

    it "is valid with a email, and password" do
        user = User.new(email: "karuma.reason1@gmail.com", password: "jbUuwYC-4lWO8JMFruPvePQGA")
        expect(user).to be_valid
    end

    it "is invalid without an email address" do
        user = FactoryBot.build(:user, email: nil)
        user.valid?
        expect(user.errors[:email]).to include(I18n.t('errors.messages.blank'))
    end

    it "is invalid without a duplicate email address" do
        FactoryBot.create(:user, email: "takkii@example.com")
        user = FactoryBot.build(:user, email: "takkii@example.com")
        user.valid?
        expect(user.errors[:email]).to include(I18n.t('errors.messages.taken'))
    end
end
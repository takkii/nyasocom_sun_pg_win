require 'rails_helper'

describe Admin do
    it "has a valid factory" do
        expect(FactoryBot.build(:admin)).to be_valid
    end

    it "is valid with a email, and password" do
        admin = Admin.new(email: "karuma_reason1@yahoo.co.jp", password: "1122rubyist")
        expect(admin).to be_valid
    end

    it "is invalid without an email address" do
        admin = FactoryBot.build(:admin, email: nil)
        admin.valid?
        expect(admin.errors[:email]).to include(I18n.t('errors.messages.blank'))
    end

    it "is invalid without a duplicate email address" do
        FactoryBot.create(:admin, email: "takkii@example.com")
        admin = FactoryBot.build(:admin, email: "takkii@example.com")
        admin.valid?
        expect(admin.errors[:email]).to include(I18n.t('errors.messages.taken'))
    end
end
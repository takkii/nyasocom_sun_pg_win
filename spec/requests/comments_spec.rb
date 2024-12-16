require 'rails_helper'

RSpec.describe "Comments", type: :request do
  describe "GET /index" do
    it "responds not successfully" do
      get comments_path
      expect(response).to_not be_successful
    end

    it "responds status 302" do
      get comments_path
      expect(response).to have_http_status(302)
    end

    it "redirects to the sign in page" do
      get comments_path
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
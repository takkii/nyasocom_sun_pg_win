require 'rails_helper'

RSpec.describe "Tops", type: :request do
  describe "GET /index" do
    it "@himekuri instance method is not nil" do
      controller.instance_variable_get("@himekuri")
    end

    it "@locale instance method is not nil" do
      controller.instance_variable_get("@locale")
    end

    it "responds successfully" do
      get root_path
      expect(response).to be_successful
    end

    it "responds status 200" do
      get root_path
      expect(response).to have_http_status(200)
    end

    it "redirects to not the sign in page" do
      get root_path
      expect(response).to_not redirect_to(new_user_session_path)
    end
  end
end

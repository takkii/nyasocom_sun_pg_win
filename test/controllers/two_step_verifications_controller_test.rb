require "test_helper"

class TwoStepVerificationsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get two_step_verifications_new_url
    assert_response :success
  end

  test "should get create" do
    get two_step_verifications_create_url
    assert_response :success
  end
end

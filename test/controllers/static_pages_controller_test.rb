require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get contact" do
    get static_pages_contact_url
    assert_response :success
  end

  test "should get privacy" do
    get static_pages_privacy_url
    assert_response :success
  end

  test "should get concept" do
    get static_pages_concept_url
    assert_response :success
  end

  test "should get team" do
    get static_pages_team_url
    assert_response :success
  end
end

require "test_helper"

class CartItemJointablesControllerTest < ActionDispatch::IntegrationTest
  test "should get destroy" do
    get cart_item_jointables_destroy_url
    assert_response :success
  end
end

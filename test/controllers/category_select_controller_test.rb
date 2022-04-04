require "test_helper"

class CategorySelectControllerTest < ActionDispatch::IntegrationTest
  test "should get cat_select" do
    get category_select_CategorySelect_url
    assert_response :success
  end
end

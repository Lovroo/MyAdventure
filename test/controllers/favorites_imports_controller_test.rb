require "test_helper"

class FavoritesImportsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get favorites_imports_new_url
    assert_response :success
  end

  test "should get create" do
    get favorites_imports_create_url
    assert_response :success
  end
end

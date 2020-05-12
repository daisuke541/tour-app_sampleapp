require 'test_helper'

class FavoriteRelationshipsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get favorite_relationships_create_url
    assert_response :success
  end

  test "should get destroy" do
    get favorite_relationships_destroy_url
    assert_response :success
  end

end

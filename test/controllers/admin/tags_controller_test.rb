require "test_helper"

class Admin::TagsControllerTest < ActionDispatch::IntegrationTest
  test "should get index,edit,create,update,destroy" do
    get admin_tags_index,edit,create,update,destroy_url
    assert_response :success
  end
end

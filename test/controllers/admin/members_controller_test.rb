require "test_helper"

class Admin::MembersControllerTest < ActionDispatch::IntegrationTest
  test "should get index,show,update" do
    get admin_members_index,show,update_url
    assert_response :success
  end
end

require "test_helper"

class Public::MembersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_members_index_url
    assert_response :success
  end

  test "should get show" do
    get public_members_show_url
    assert_response :success
  end

  test "should get edit" do
    get public_members_edit_url
    assert_response :success
  end

  test "should get update" do
    get public_members_update_url
    assert_response :success
  end
end

require 'test_helper'

class MailingListsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get mailing_lists_index_url
    assert_response :success
  end

  test "should get new" do
    get mailing_lists_new_url
    assert_response :success
  end

  test "should get create" do
    get mailing_lists_create_url
    assert_response :success
  end

  test "should get edit" do
    get mailing_lists_edit_url
    assert_response :success
  end

  test "should get update" do
    get mailing_lists_update_url
    assert_response :success
  end

  test "should get destroy" do
    get mailing_lists_destroy_url
    assert_response :success
  end

end

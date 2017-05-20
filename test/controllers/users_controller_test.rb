require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::ControllerHelpers
  # test "the truth" do
  #   assert true
  # end

  setup do
    @user = users(:bob)
  end

  # test 'GET new' do
  #   @request.env['devise.mapping'] = Devise.mappings[:user]
  #   sign_in users(:bob)

  #   get :new
  #   assert_redirected_to user_edit_url(User.last)
  # end

  # test "should get index" do
  #   get users_url
  #   assert_response :success
  # end

  # test "should destroy the user" do
  #   assert_difference('User.count', -1) do
  #     delete users_url(@user)
  #   end

  #   assert_redirected_to users_url
  # end
end

require 'test_helper'

class PostsTestsTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  # test "the truth" do
  #   assert true
  # end
  test "login/logout test" do
    sign_in users(:bob)

    sign_out :user
  end
end

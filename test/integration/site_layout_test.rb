require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test "layout links" do
    get root_path
    assert_template 'employees/index'
    assert_select "a[href=?]", root_path, count: 0
    assert_select "a[href=?]", signin_path
    assert_select "a[href=?]", signup_path
    # assert_select "a[href=?]", signout_path
  end
end

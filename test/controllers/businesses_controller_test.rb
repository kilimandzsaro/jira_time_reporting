require 'test_helper'

class BusinessesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @b1 = businesses(:one)
    @b2 = businesses(:two)
  end

  test "should get index" do
    get businesses_url
    assert_response :success
  end

  test "should create business" do
    assert_difference('Business.count') do
      b2 = Business.new(name: "Random name", price: 2.22)
      b2.save!
    end
  end

  test "should show business" do
    get businesses_url(@business)
    assert_response :success
  end

  test "should update business name" do
    put business_url(@b1.id), params: { business: { name: "Other Name Of The Business" }}
    assert_equal "Other Name Of The Business", @b1.reload.name
    assert_redirected_to businesses_url
  end

  test "should update the price of the business" do
    patch business_url(@b2.id), params: { business: { price: 2.22 }}
    assert_equal 2.22, @b2.reload.price
    assert_redirected_to businesses_url
  end

  test "should not update the jira_name field" do
    original_jira_name = @b1.jira_name
    patch business_url(@b1.id), params: { business: { jira_name: "New jira name" }}
    assert_equal original_jira_name, @b1.reload.jira_name
    assert_redirected_to businesses_url
  end

  test "should get the edit page" do
    get edit_business_url(@b1)
    assert_response :success
  end

end

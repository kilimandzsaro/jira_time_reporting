require 'test_helper'

class BusinessesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @business = businesses(:one)
  end

  test "should get index" do
    get businesses_url
    assert_response :success
  end

  test "should create business" do
    assert_difference('Business.count') do
      post businesses_url, params: { business: { name: @business.name, price: @business.price } }
    end

    assert_redirected_to businesses_url(Business.last)
  end

  test "should show business" do
    get businesses_url(@business)
    assert_response :success
  end

  test "should update business" do
    patch businesses_url(@business), params: { business: { name: @business.name, price: @business.price } }
    assert_redirected_to businesses_url(@business)
  end

end

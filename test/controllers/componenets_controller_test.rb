require 'test_helper'

class ComponenetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @componenet = componenets(:one)
  end

  test "should get index" do
    get componenets_url
    assert_response :success
  end

  test "should get new" do
    get new_componenet_url
    assert_response :success
  end

  test "should create componenet" do
    assert_difference('Componenet.count') do
      post componenets_url, params: { componenet: { name: @componenet.name } }
    end

    assert_redirected_to componenet_url(Componenet.last)
  end
end

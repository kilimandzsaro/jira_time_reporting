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

  test "should show componenet" do
    get componenet_url(@componenet)
    assert_response :success
  end

  test "should get edit" do
    get edit_componenet_url(@componenet)
    assert_response :success
  end

  test "should update componenet" do
    patch componenet_url(@componenet), params: { componenet: { name: @componenet.name } }
    assert_redirected_to componenet_url(@componenet)
  end

  test "should destroy componenet" do
    assert_difference('Componenet.count', -1) do
      delete componenet_url(@componenet)
    end

    assert_redirected_to componenets_url
  end
end
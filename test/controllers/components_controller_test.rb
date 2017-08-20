require 'test_helper'

class ComponentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @component = components(:one)
  end

  test "should get index" do
    get components_url
    assert_response :success
  end

  test "should create component" do
    assert_difference('Component.count') do
      post components_url, params: { component: { name: "Random component" } }
    end
    assert_equal "Random component", Component.last.name
  end

end

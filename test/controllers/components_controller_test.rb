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

  test "should get all components and upload the new ones"
    mock = Minitest::Mock.new
    project = Project.first

    mock.expect :new, true # Mocking GetJiraResponseService.new
    mock.expect :all, [project] # Mocking Project.all
    mock.expect :project_components, ['another'], [project] # Mocking GetJiraResponseService.project_components(project)

    GetJiraResponseService.stub :new, mock do
      # assert_difference('Component.count') do
        Component.get
      # end
    end

    assert_mock mock
end

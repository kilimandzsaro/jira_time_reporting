require 'test_helper'

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @project = projects(:one)
  end

  test "should get index" do
    get projects_url
    assert_response :success
  end

  test "should create project" do
    assert_difference('Project.count') do
      post projects_url, params: { project: { prefix: @project.prefix, name: @project.name } }
    end

    assert_redirected_to project_url(Project.last)
  end

  test "should show project" do
    get projects_url(@project)
    assert_response :success
  end

  test "should destroy project" do
    assert_difference('Project.count', -1) do
      delete projects_url(@project)
    end

    assert_redirected_to projects_url
  end
end

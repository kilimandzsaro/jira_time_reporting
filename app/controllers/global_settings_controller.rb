class GlobalSettingsController < ApplicationController
  before_action :signed_in_user, only: [:show, :edit, :update, :destroy]
  before_action :set_global_setting, only: [:show, :edit, :update, :destroy]

  # GET /global_settings
  def index
    @global_settings = GlobalSetting.all
  end

  # GET /global_settings/1
  def show
    @global_setting = GlobalSetting.find(params[:id])
  end

  # GET /global_settings/new
  def new
    @global_setting = GlobalSetting.new
    @regions = Holidays.available_regions
  end

  # GET /global_settings/1/edit
  def edit
    @global_setting = GlobalSetting.find(params[:id])
    @regions = Holidays.available_regions
  end

  # POST /global_settings
  def create
    @global_setting = GlobalSetting.new(global_setting_params)

    if @global_setting.save
      redirect_to @global_setting, notice: 'Global setting was successfully created.'
    else
      render :new
    end
  end

  def get
    # auth = GlobalSetting.find_by_active(true).base64_key
    connect_to_jira = GetJiraResponseService.new
    
    get_all_components_and_issues(connect_to_jira)
    get_all_issue_histories(connect_to_jira)

    set_end_dates
    
    IssueHistory.all.each do |ih|
      ihs = IssueHistoriesService.new(ih)
      ihs.calculate_duration
    end

    redirect_to global_settings_path
  end

  # PATCH/PUT /global_settings/1
  def update
    if @global_setting.update(global_setting_params)
      redirect_to @global_setting, notice: 'Global setting was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /global_settings/1
  def destroy
    @global_setting.destroy
    redirect_to global_settings_url, notice: 'Global setting was successfully destroyed.'
  end

  private
  def get_all_components_and_issues(connect_to_jira)
    Project.all.each do |project|
      components = Array.new
      components = connect_to_jira.project_components(project.id)
      cs = ComponentsService.new
      cs.add_new_components(components)

      issues = Array.new
      issues = connect_to_jira.all_issues(project.id)
      is = IssuesService.new
      is.add_new_issues(issues)
    end
  end

  def get_all_issue_histories(connect_to_jira)
    Issue.all.each do |i|
      history = connect_to_jira.issue_history(i.issue_key)
      h = IssueHistoriesService.new(history)
      h.process_issue_history
    end
  end

  def set_end_dates
    Issue.all.each do |i|
      end_date = ""
      IssueHistory.order("changelog_id_tag DESC").where("issue_id = ?", i).each do |ih|
        ih.end_date = end_date
        end_date = ih.start_date
        ih.save
      end
    end
  end
  
  # Use callbacks to share common setup or constraints between actions.
  def set_global_setting
    @global_setting = GlobalSetting.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def global_setting_params
    params.require(:global_setting).permit(:name, :url, :base64_key, :active, :region)
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, flash: {warning: "Please sign in."}
    end
  end
end

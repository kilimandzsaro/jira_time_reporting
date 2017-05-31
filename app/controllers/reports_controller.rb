class ReportsController < ApplicationController
  before_action :signed_in_user, only: [:show, :edit, :update, :destroy]
  before_action :set_report, only: [:show, :edit, :update, :destroy]

  # GET /reports
  # GET /reports.json
  def index
    @reports = Report.all
  end

  # GET /reports/1
  # GET /reports/1.json
  def show
    @report = Report.find(params[:id])
    @r_type = @report.settings['report_types']
    @e_ids = @report.settings['employee_ids']
    @b_ids = @report.settings['business_ids']
    @c_ids = @report.settings['component_ids']
    @p_ids = @report.settings['project_ids']
    @stat = @report.settings['status_ids']
  end

  # GET /reports/new
  def new
    @report = Report.new
  end

  # GET /reports/1/edit
  def edit
    @report = Report.find(params[:id])
    @r_type = @report.settings['report_types']
    @e_ids = @report.settings['employee_ids']
    @b_ids = @report.settings['business_ids']
    @c_ids = @report.settings['component_ids']
    @p_ids = @report.settings['project_ids']
    @stat = @report.settings['status_ids']
  end

  def get
    report = Report.find(params[:report_id])
    auth = "bmF0YWxpYS5iYWtvc0BpbmJhbmsuZWU6TGl2ZUBuZGxldGwxdmVUcnVlRnIzZWRvbQ=="
    connect_to_jira = GetJiraResponseService.new("application/json", "Basic #{auth}")

    report.settings['project_ids'].each do |project|
      components = Array.new
      components = connect_to_jira.project_components(project)
      cs = ComponentsService.new
      cs.add_new_components(components)

      issues = Array.new
      issues = connect_to_jira.all_issues(project)
      is = IssuesService.new
      is.add_new_issues(issues)
    end

    Issue.where("is_done = false").each do |i|
      history = connect_to_jira.issue_history(i.issue_key)
      h = IssueHistoriesService.new
      h.process_issue_history(history)
    end
  end

  # POST /reports
  # POST /reports.json
  def create
    @report = Report.new(report_params)
    @report.settings['report_types'].shift
    @report.settings['employee_ids'].shift
    @report.settings['business_ids'].shift
    @report.settings['component_ids'].shift
    @report.settings['status_ids'].shift
    @report.settings['project_ids'].shift

    respond_to do |format|
      if @report.save
        format.html { redirect_to @report, notice: 'Report was successfully created.' }
        format.json { render :show, status: :created, location: @report }
      else
        format.html { render :new }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reports/1
  # PATCH/PUT /reports/1.json
  def update
    @report = Report.find(params[:id])
    @report.settings['report_types'].shift
    @report.settings['employee_ids'].shift
    @report.settings['business_ids'].shift
    @report.settings['component_ids'].shift
    @report.settings['status_ids'].shift
    @report.settings['project_ids'].shift
    respond_to do |format|
      if @report.save
        format.html { redirect_to @report, notice: 'Report was successfully updated.' }
        format.json { render :show, status: :ok, location: @report }
      else
        format.html { render :edit }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reports/1
  # DELETE /reports/1.json
  def destroy
    @report.destroy
    respond_to do |format|
      format.html { redirect_to reports_url, notice: 'Report was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = Report.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def report_params
      # params.require(:report).permit(:name => "", :from_date => "", :to_date => "", 
      #     :settings =>
      #       [:report_types, :employee_ids, :component_ids, :business_ids, :status_ids ]
      #   )
      params.require(:report).permit!
    end

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, flash: {warning: "Please sign in."}
      end
    end
end

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
  end

  # GET /reports/new
  def new
    @report = Report.new
  end

  # GET /reports/1/edit
  def edit
  end

  def get
    project = "INBT"
    auth = "bmF0YWxpYS5iYWtvc0BpbmJhbmsuZWU6TGl2ZUBuZGxldGwxdmVUcnVlRnIzZWRvbQ=="
    connect_to_jira = GetJiraResponseService.new("application/json", "Basic #{auth}")

    components = Array.new
    components = connect_to_jira.project_components(project)

    c = ComponentsService.new
    c.add_new_components(components)

    issues = Array.new
    issues = connect_to_jira.all_issues(project)
    i = IssuesService.new
    i.add_new_issues(issues)
  end

  # POST /reports
  # POST /reports.json
  def create
    @report = Report.new(report_params)

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
    respond_to do |format|
      if @report.update(report_params)
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
    #  "report"=>{"name"=>"first", "from_date"=>"2017-04-01", "to_date"=>"2017-04-30", "settings"=>["", "32", "", "2", "", ""]}
    def report_params
      params.require(:report).permit(:name, :from_date, :to_date, 
          { settings: 
            [{report_type: :id}, {employee_ids: :id}, {component_ids: :id}, {business_ids: :id} ] }
        )
    end

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, flash: {warning: "Please sign in."}
      end
    end
end

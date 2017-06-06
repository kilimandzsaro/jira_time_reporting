class ReportsController < ApplicationController
  before_action :signed_in_user, only: [:show, :edit, :update, :destroy]
  before_action :set_report, only: [:show, :edit, :update, :destroy, :get_results]

  # GET /reports
  # GET /reports.json
  def index
    @reports = Report.all
  end

  # GET /reports/1
  # GET /reports/1.json
  def show
  end

  # GET /reports/new
  def new
    @report = Report.new
  end

  def get_report
    # ReportResult.create(params)
    # redirect_to new_report_result_path(params[:report_id])
    report = Report.find(params[:report_id])

    EmployeesReportType.where(report_type_id: report.report_type_id).each do |employee|
      rrs = ReportResultsService.new(report.from_date, report.to_date, employee.employee_id, report.id)
      spent = rrs.get_original_times
      calculated = rrs.get_calculated_work_hours
      ReportResult.where(report_id: params[:report_id]).each do |rr|
        rrs.calculate_and_save_personal_times(rr.id, spent, calculated)
      end
    end
    redirect_to report_results_path
  end

  def get_results
  end

  # GET /reports/1/edit
  def edit
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
    ReportResult.where("report_id = ?", @report.id).each { |rr| rr.destroy}
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
      params.require(:report).permit(:name, :from_date, :to_date, :report_type_id )
      # params.require(:report).permit!
    end

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, flash: {warning: "Please sign in."}
      end
    end
end

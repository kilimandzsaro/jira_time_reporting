class ReportResultsController < ApplicationController
  before_action :signed_in_user
  before_action :set_report_result, only: [:update]

  # GET /report_results
  def index
    @ran_reports = ReportResult.find_by_sql("SELECT report_id FROM report_results GROUP BY report_id")
    @report_results = Report.all
  end

  # GET /report_results/new
  def new
    @report_result = ReportResult.new
  end

  # GET /report_results/1/edit
  def edit
  end

  # POST /report_results
  def create
   
  end

  # PATCH/PUT /report_results/1
  def update
    if @report_result.update(report_result_params)
      redirect_to @report_result, notice: 'Report result was successfully updated.'
    else
      render :edit
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_report_result
    @report_result = ReportResult.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def report_result_params
    params.fetch(:report_result, {})
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, flash: {warning: "Please sign in."}
    end
  end
end

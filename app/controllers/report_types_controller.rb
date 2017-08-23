class ReportTypesController < ApplicationController
  before_action :signed_in_user
  # before_action :set_report_type, only: [:edit]

  # GET /report_types
  # GET /report_types.json
  def index
    @report_types = ReportType.all
  end

  # GET /report_types/new
  def new
    @report_type = ReportType.new
  end

  # GET /report_types/1/edit
  def edit
    set_report_type
  end

  def show
    set_report_type
  end

  # PATCH/PUT /report_types/1
  def update
    set_report_type
    respond_to do |format|
      if @report_type.update_attributes(update_report_type_params)
        format.html do
          redirect_to report_types_path
        end
        format.json { render json: @report_type.to_json}
      else
        format.html { render :edit }
        format.json { render json: @report_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /report_types
  # POST /report_types.json
  def create
    @report_type = ReportType.new(update_report_type_params)
    @report_type.employee_ids.shift
    @report_type.component_ids.shift
    @report_type.project_ids.shift
    @report_type.business_ids.shift
    @report_type.status_ids.shift

    respond_to do |format|
      if @report_type.save!
        # flash[:success] = "Report types has been created successfully"
        # redirect_to report_types_path
        format.html do
          redirect_to report_types_path
        end
        format.json { render json: @report_type.to_json}
      else
        format.html { render :new }
        format.json { render json: @report_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /report_types/1
  # DELETE /report_types/1.json
  def destroy
    @report_type = ReportType.find(params[:id])
    BusinessesReportType.where("report_type_id = ?", @report_type.id).each {|brt| brt.destroy}
    ComponentsReportType.where("report_type_id = ?", @report_type.id).each {|crt| crt.destroy}
    EmployeesReportType.where("report_type_id = ?", @report_type.id).each {|ert| ert.destroy}
    ProjectsReportType.where("report_type_id = ?", @report_type.id).each {|prt| prt.destroy}
    StatusesReportType.where("report_type_id = ?", @report_type.id).each {|srt| srt.destroy}
    @report_type.destroy
    respond_to do |format|
      format.html { redirect_to report_types_url, notice: 'Report type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_report_type
    @report_type = ReportType.find(params[:id])
  end

  def update_report_type_params
    params.require(:report_type).permit(:name, :employee_ids => [], :component_ids => [], :business_ids => [], :project_ids => [], :status_ids => [])
    # params.require(:report_type).permit!
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, flash: {warning: "Please sign in."}
    end
  end

end

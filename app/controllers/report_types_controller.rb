class ReportTypesController < ApplicationController
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

  # PATCH/PUT /report_types/1
  def update
    @report_type = ReportType.find(params[:id])
    respond_to do |format|
      if @report_type.update_attributes(update_report_type_params["report_types"])
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
    @report_type = ReportType.new(update_report_type_params["report_types"])

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
      params.require(:report_type).permit(report_types: [:id, :report_type])
    end

end

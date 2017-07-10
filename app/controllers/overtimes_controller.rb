class OvertimesController < ApplicationController
  before_action :set_overtime, only: [:update, :destroy]

  # POST /overtimes
  def create
    @overtime = Overtime.new(overtime_params)
    respond_to do |format|
      if @overtime.save
        format.js {render inline: "location.reload();" }
      end
    end
  end

  # PATCH/PUT /overtimes/1
  def update
    @overtime.update!(overtime_params)
  end

  # DELETE /overtimes/1
  def destroy
    @overtime.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_overtime
      @overtime = Overtime.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def overtime_params
      params.require(:overtime).permit(:start_date, :end_date, :employee_id, :report_id, :hours)
    end
end

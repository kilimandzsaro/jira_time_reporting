class VacationsController < ApplicationController
  before_action :set_vacation, only: [:update, :destroy]

  # POST /vacations
  def create
    @vacation = Vacation.new(vacation_params)
    if @vacation.save
      redirect_back(fallback_location: edit_report_path(@vacation.report_id))
    end
  end

  # PATCH/PUT /vacations/1
  def update
    @vacation.update!(vacation_params)
  end

  # DELETE /vacations/1
  def destroy
    @vacation.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vacation
      @vacation = Vacation.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def vacation_params
      params.require(:vacation).permit(:start_date, :end_date, :employee_id, :report_id)
    end
end

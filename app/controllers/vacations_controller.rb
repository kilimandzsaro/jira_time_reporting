class VacationsController < ApplicationController
  before_action :set_vacation, only: [:show, :edit, :update, :destroy]

  # GET /vacations
  def index
    @vacations = Vacation.all
  end

  # GET /vacations/1
  def show
  end

  # GET /vacations/new
  def new
    @vacation = Vacation.new
  end

  # GET /vacations/1/edit
  def edit
  end

  # POST /vacations
  def create
    @vacation = Vacation.new(vacation_params)

    if @vacation.save
      redirect_to @vacation, notice: 'Vacation was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /vacations/1
  def update
    if @vacation.update(vacation_params)
      redirect_to @vacation, notice: 'Vacation was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /vacations/1
  def destroy
    @vacation.destroy
    redirect_to vacations_url, notice: 'Vacation was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vacation
      @vacation = Vacation.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def vacation_params
      params.require(:vacation).permit(:from_date, :to_date, :employee_id)
    end
end

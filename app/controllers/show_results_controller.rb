class ShowResultsController < ApplicationController
  before_action :set_show_result, only: [:show, :edit, :update, :destroy]

  # GET /show_results
  def index
    @show_results = ShowResult.all
  end

  # GET /show_results/1
  def show
  end

  # GET /show_results/new
  def new
    @show_result = ShowResult.new
  end

  # GET /show_results/1/edit
  def edit
  end

  # POST /show_results
  def create
    @show_result = ShowResult.new(show_result_params)

    if @show_result.save
      redirect_to @show_result, notice: 'Result view was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /show_results/1
  def update
    if @show_result.update(show_result_params)
      redirect_to @show_result, notice: 'Result view was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /show_results/1
  def destroy
    @show_result.destroy
    redirect_to show_results_url, notice: 'Result view was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_show_result
      @show_result = ShowResult.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def show_result_params
      params.require(:show_result).permit(:name, :template)
    end
end

class ResultViewsController < ApplicationController
  before_action :set_result_view, only: [:show, :edit, :update, :destroy]

  # GET /result_views
  def index
    @result_views = ResultView.all
  end

  # GET /result_views/1
  def show
  end

  # GET /result_views/new
  def new
    @result_view = ResultView.new
  end

  # GET /result_views/1/edit
  def edit
  end

  # POST /result_views
  def create
    @result_view = ResultView.new(result_view_params)

    if @result_view.save
      redirect_to @result_view, notice: 'Result view was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /result_views/1
  def update
    if @result_view.update(result_view_params)
      redirect_to @result_view, notice: 'Result view was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /result_views/1
  def destroy
    @result_view.destroy
    redirect_to result_views_url, notice: 'Result view was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_result_view
      @result_view = ResultView.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def result_view_params
      params.require(:result_view).permit(:name, :template)
    end
end

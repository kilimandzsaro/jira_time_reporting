class ComponentsController < ApplicationController
  before_action :set_component, only: [:show, :destroy]
  include HTTParty

  # GET /components
  # GET /components.json
  def index
    @components = Component.all
  end

  # GET /components/get
  def get
    GetJiraResponseService.new("application/json","Base #{ENV['JIRA_BASE64']}")
    GetJiraResponseService.all_issues("INBT")
  end

  # GET /components/new
  def new
    @component = Component.new
  end

  # POST /components
  # POST /components.json
  def create
    @component = Component.new(component_params)

    respond_to do |format|
      if @component.save
        format.html { redirect_to @component, notice: 'Component was successfully created.' }
        format.json { render :show, status: :created, location: @component }
      else
        format.html { render :new }
        format.json { render json: @component.errors, status: :unprocessable_entity }
      end
    end
  end

  # # DELETE /components/1
  # # DELETE /components/1.json
  # def destroy
  #   @component.destroy
  #   respond_to do |format|
  #     format.html { redirect_to components_url, notice: 'Component was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_component
      @component = Component.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def component_params
      params.require(:component).permit(:name)
    end

end

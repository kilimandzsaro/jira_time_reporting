class ComponentsController < ApplicationController
  before_action :signed_in_user, only: [:show]
  before_action :set_component, only: [:show]
  include HTTParty

  # GET /components
  # GET /components.json
  def index
    @components = Component.all
  end

  def new
  end

  # POST /components
  # POST /components.json
  def create
    @component = Component.new(component_params)
    @component.save
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_component
    @component = Component.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def component_params
    params.require(:component).permit(:name)
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, flash: {warning: "Please sign in."}
    end
  end

end

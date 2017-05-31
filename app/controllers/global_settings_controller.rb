class GlobalSettingsController < ApplicationController
  before_action :set_global_setting, only: [:show, :edit, :update, :destroy]

  # GET /global_settings
  def index
    @global_settings = GlobalSetting.all
  end

  # GET /global_settings/1
  def show
    @global_setting = GlobalSetting.find(params[:id])
  end

  # GET /global_settings/new
  def new
    @global_setting = GlobalSetting.new
  end

  # GET /global_settings/1/edit
  def edit
    @global_setting = GlobalSetting.find(params[:id])
  end

  # POST /global_settings
  def create
    @global_setting = GlobalSetting.new(global_setting_params)

    if @global_setting.save
      redirect_to @global_setting, notice: 'Global setting was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /global_settings/1
  def update
    if @global_setting.update(global_setting_params)
      redirect_to @global_setting, notice: 'Global setting was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /global_settings/1
  def destroy
    @global_setting.destroy
    redirect_to global_settings_url, notice: 'Global setting was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_global_setting
      @global_setting = GlobalSetting.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def global_setting_params
      params.require(:global_setting).permit(:name, :url, :base64_key, :active)
    end
end

class StatusesController < ApplicationController
  # before_action :set_status, only: [:refresh, :destroy]

  # GET /statuses
  def index
    @statuses = Status.all
  end

  # POST /statuses
  def create
    @status = Status.new(status_params)

    if @status.save
      redirect_to statuses_path, notice: 'Status was successfully created.'
    else
      render :new
    end
  end

  def edit
    set_status
  end

  def update
    @status.counted = params[:counted]
    if @status.save
      redirect_to statuses_path, notice: 'Status was successfully updated'
    else
      render :edit
    end
  end


  # GET /statuses#refresh
  def refresh
    connect_to_jira = GetJiraResponseService.new
    statuses = connect_to_jira.statuses
    statuses.each do |status|
      if Status.find_by(name: status['name']).nil?
        s = Status.new
        s.name = status['name']
        s.save
      end
    end
    redirect_to statuses_path, notice: 'Status was successfully updated'
  end

  # DELETE /statuses/1
  def destroy
    @status.destroy
    redirect_to statuses_path, notice: 'Status was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_status
      @status = Status.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def status_params
      params.require(:status).permit(:counted)
    end
end

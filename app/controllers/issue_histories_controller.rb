class IssueHistoriesController < ApplicationController
  before_action :set_issue_history, only: [:show, :edit, :update, :destroy]

  # GET /issue_histories
  # GET /issue_histories.json
  def index
    @issue_histories = IssueHistory.all
  end

  # GET /issue_histories/1
  # GET /issue_histories/1.json
  def show
    @issue_histories = IssueHistory.find(params[:id])
    @issue_history_issue = Issue.find(@issue_histories.issue_id)
    @issue_histories_employee = Employee.find(@issue_histories.employee_id)
    @issue_histories.component_id.each do |cid|
      @issue_histories_components.push(Component.find(cid))
    end
    @issue_histories.business_id.each do |bid|
      @issue_histories_business.push(Business.find(bid))
    end
    @issue_histories_project = Project.find(@issue_histories.project_id)
  end

  # POST /issue_histories
  # POST /issue_histories.json
  def create
    @issue_history = IssueHistory.new(issue_history_params)

    respond_to do |format|
      if @issue_history.save
        format.html { redirect_to @issue_history, notice: 'Issue history was successfully created.' }
        format.json { render :show, status: :created, location: @issue_history }
      else
        format.html { render :new }
        format.json { render json: @issue_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /issue_histories/1
  # PATCH/PUT /issue_histories/1.json
  def update
    respond_to do |format|
      if @issue_history.update(issue_history_params)
        format.html { redirect_to @issue_history, notice: 'Issue history was successfully updated.' }
        format.json { render :show, status: :ok, location: @issue_history }
      else
        format.html { render :edit }
        format.json { render json: @issue_history.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_issue_history
      @issue_history = IssueHistory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def issue_history_params
      params.fetch(:issue_history, {})
    end
end

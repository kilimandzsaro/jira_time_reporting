class IssuesController < ApplicationController
  before_action :signed_in_user
  before_action :set_issue, only: [:show, :edit, :update, :destroy]

  # GET /issues
  # GET /issues.json
  def index
    @issues = Issue.order(:issue_key).page(params[:page])
  end

  # GET /issues/1
  # GET /issues/1.json
  def show
    @issue = Issue.find(params[:id])
    @issue_histories = IssueHistory.where(issue_id: params[:id])
  end

  # GET /issues/new
  def new
    @issue = Issue.new
  end

  # GET /issues/1/edit
  def edit
  end

  # POST /issues
  # POST /issues.json
  def create
    @issue = Issue.new(issue_params)
    @issue.save
  end

  # PATCH/PUT /issues/1
  # PATCH/PUT /issues/1.json
  def update
    @issue.update(issue_params)
  end

  # DELETE /issues/1
  # DELETE /issues/1.json
  def destroy
    @issue.destroy
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_issue
    @issue = Issue.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def issue_params
    params.fetch(:issue, {})
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, flash: {warning: "Please sign in."}
    end
  end

end

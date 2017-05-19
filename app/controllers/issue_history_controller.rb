class IssueHistoryController < ApplicationController
  # GET /issue_histories
  # GET /issue_histories.json
  def index
    @issue_histories = IssueHistory.all
  end

  # GET /issue_histories/1
  # GET /issue_histories/1.json
  def show
  end
end

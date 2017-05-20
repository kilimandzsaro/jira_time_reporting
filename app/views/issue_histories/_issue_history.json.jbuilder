json.extract! issue_history, :id, :created_at, :updated_at
json.url issue_history_url(issue_history, format: :json)

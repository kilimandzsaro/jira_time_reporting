json.extract! employee, :id, :name, :email, :created_at, :updated_at, :issue_history_id, :hide, :status
json.url employee_url(employee, format: :json)

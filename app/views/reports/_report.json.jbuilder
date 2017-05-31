json.extract! report, :id, :name, :from_date, :to_date, :settings, :created_at, :updated_at
json.url report_url(report, format: :json)

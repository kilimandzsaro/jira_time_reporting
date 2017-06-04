json.extract! report, :id, :name, :from_date, :to_date, :report_type_id
json.url report_url(report, format: :json)

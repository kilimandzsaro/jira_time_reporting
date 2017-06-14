json.extract! report_type, :name, :employee_ids, :business_ids, :component_ids, :project_ids, :status_ids  :created_at, :updated_at
json.url report_type_url(report_types, format: :json)

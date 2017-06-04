class AddCreateRelationsTablesToReportTypesTable < ActiveRecord::Migration[5.0]
  def change
    remove_column :report_types, :report_type
    add_column    :report_types, :name, :string, unique: true

    create_table :employees_report_types do |t|
      t.references :employee, index: true, foreign_key: true
      t.references :report_type, index: true, foreign_key: true
    end

    create_table :components_report_types do |t|
      t.references :component, index: true, foreign_key: true
      t.references :report_type, index: true, foreign_key: true
    end

    create_table :businesses_report_types do |t|
      t.references :business, index: true, foreign_key: true
      t.references :report_type, index: true, foreign_key: true
    end

    create_table :projects_report_types do |t|
      t.references :project, index: true, foreign_key: true
      t.references :report_type, index: true, foreign_key: true
    end
  end
end

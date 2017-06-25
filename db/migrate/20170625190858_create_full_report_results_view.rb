class CreateFullReportResultsView < ActiveRecord::Migration[5.0]
  def up
    execute <<-SQL
        CREATE VIEW full_report_results_view AS
            SELECT rr.id AS report_id,
                r.report_type_id AS rt_id,
                rr.spent,
                rr.calculated,
                e.display_name AS "employee",
                i.issue_key AS "issue",
                c.name AS "component",
                p.name AS "project",
                b.name AS "business"
            FROM    
                ( report_results rr
                  LEFT JOIN reports r ON rr.report_id = r.id
                  )
                INNER JOIN components_issues ci ON rr.issue_id = ci.issue_id 
                INNER JOIN businesses_issues bi ON bi.issue_id = rr.issue_id
                LEFT JOIN employees e ON e.id = rr.employee_id
                LEFT JOIN issues i ON i.id = rr.issue_id
                LEFT JOIN components c ON c.id = ci.component_id
                LEFT JOIN projects p ON p.id = i.project_id
                LEFT JOIN businesses b ON b.id = bi.business_id
    SQL
  end

  def down
    execute "DROP VIEW full_report_results_view"
  end
end

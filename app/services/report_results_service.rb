class ReportResultsService
  
  attr_accessor :from_date, :to_date, :employee_id, :report_id, :counted_statuses

  def initialize(from_date, to_date, employee_id, report_id)
    self.from_date = from_date
    self.to_date = to_date
    self.employee_id = employee_id
    self.report_id = report_id
    self.counted_statuses = Array.new
    Status.where("counted = ?", true).each { |s| counted_statuses << s.id }
  end

  def get_original_times
    record_durations
    duration = 0
    ReportResult.where("report_id = ?", report_id).where("employee_id = ?", employee_id).each do |rr|
      duration += rr.spent
    end
    return duration
  end

  def get_calculated_work_hours
    p "FROM DATE: #{from_date}, TO DATE: #{to_date}"
    return from_date.business_days_until(to_date) * 6
  end

  def calculate_and_save_personal_times(report_result_id, original_sum_time, calculated_sum_time)
    rr = ReportResult.find(report_result_id)
    rr.calculated = ((rr.spent * calculated_sum_time) / original_sum_time).round unless original_sum_time == 0
    p "RRRR: #{rr.calculated}"
    rr.save!
  end

  private

  def record_durations
    start_date_less_than_from_date_and_end_date_is_out_of_range
    start_date_less_than_from_date_and_end_date_between_the_range
    start_date_between_the_range_and_end_date_is_out_of_range
    start_date_between_the_range_and_end_date_between_the_range
  end

  def start_date_less_than_from_date_and_end_date_is_out_of_range
    issue_history = IssueHistory.where("start_date < ?", from_date)
                     .where("end_date IS NULL OR end_date > ?", to_date)
                     .where("employee_id = ?", employee_id)
                     .where("status_id IN (?)", counted_statuses)
    issue_history.each do |ih|
      if ReportResult.find_by(issue_id: ih.issue_id, employee_id: employee_id, report_id: report_id).nil?
        p "FROM_DATE: #{from_date}, TO DATE: #{to_date}"
        d = Time.parse(from_date.to_s).business_time_until(Time.parse(to_date.to_s))
        p "D: #{d}"
        save_report_result(employee_id, d, ih.issue_id, report_id)
      end
    end
  end

  def start_date_less_than_from_date_and_end_date_between_the_range
    issue_history = IssueHistory.where("start_date < ?", from_date)
                     .where("end_date BETWEEN ? AND ?", from_date, to_date)
                     .where("employee_id = ?", employee_id)
                     .where("status_id IN (?)", counted_statuses)
    issue_history.each do |ih|
      if ReportResult.find_by(issue_id: ih.issue_id, employee_id: employee_id, report_id: report_id).nil?
        p "FROM_DATE: #{from_date}, IH END DATE: #{ih.end_date}"
        d = Time.parse(from_date.to_s).business_time_until(Time.parse(ih.end_date.to_s))
        p "D: #{d}"
        save_report_result(employee_id, d, ih.issue_id, report_id)
      end
    end
  end

  def start_date_between_the_range_and_end_date_is_out_of_range
    issue_history = IssueHistory.where("start_date BETWEEN ? AND ?", from_date, to_date)
                     .where("end_date IS NULL OR end_date > ?", to_date)
                     .where("employee_id = ?", employee_id)
                     .where("status_id IN (?)", counted_statuses)
    issue_history.each do |ih|
      if ReportResult.find_by(issue_id: ih.issue_id, employee_id: employee_id, report_id: report_id).nil?
        p "IH START DATE: #{ih.start_date}, TO END: #{to_date}"
        d = Time.parse(ih.start_date.to_s).business_time_until(Time.parse(to_date.to_s))
        p "D: #{d}"
        save_report_result(employee_id, d, ih.issue_id, report_id)
      end
    end
  end

  def start_date_between_the_range_and_end_date_between_the_range
    issue_history = IssueHistory.where("start_date BETWEEN ? AND ?", from_date, to_date)
                     .where("end_date BETWEEN ? AND ?", from_date, to_date)
                     .where("employee_id = ?", employee_id)
                     .where("status_id IN (?)", counted_statuses)
    issue_history.each do |ih|
      if ReportResult.find_by(issue_id: ih.issue_id, employee_id: employee_id, report_id: report_id).nil?
        p "IH START DATE: #{ih.start_date}, IH END DATE: #{ih.end_date}"
        d = Time.parse(ih.start_date.to_s).business_time_until(Time.parse(ih.end_date.to_s))
        p "D: #{d}"
        save_report_result(employee_id, d, ih.issue_id, report_id)
      end
    end
  end

  def save_report_result(employee_id, spent, issue_id, report_id)
    rr = ReportResult.new(employee_id: employee_id, spent: spent, issue_id: issue_id, report_id: report_id)
    rr.save!
  end
end
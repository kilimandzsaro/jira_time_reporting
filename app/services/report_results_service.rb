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
    if to_date - from_date < (4 * 60 * 60) # less than 4 hours
      return (to_date - from_date)
    else
      return from_date.business_time_until(to_date)
    end
  end

  def calculate_and_save_personal_times(report_result_id, original_sum_time, calculated_sum_time)
    rr = ReportResult.find(report_result_id)
    rr.calculated = ((rr.spent * calculated_sum_time) / original_sum_time).round(2) unless original_sum_time == 0
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

    save_report_result(employee_id, calculate_duration(issue_history, from_date, to_date), ih.issue_id, report_id)
  end

  def start_date_less_than_from_date_and_end_date_between_the_range
    issue_history = IssueHistory.where("start_date < ?", from_date)
                     .where("end_date BETWEEN ? AND ?", from_date, to_date)
                     .where("employee_id = ?", employee_id)
                     .where("status_id IN (?)", counted_statuses)

    save_report_result(employee_id, calculate_duration(issue_history, from_date, ih.end_date), ih.issue_id, report_id)
  end

  def start_date_between_the_range_and_end_date_is_out_of_range
    issue_history = IssueHistory.where("start_date BETWEEN ? AND ?", from_date, to_date)
                     .where("end_date IS NULL OR end_date > ?", to_date)
                     .where("employee_id = ?", employee_id)
                     .where("status_id IN (?)", counted_statuses)
    
    save_report_result(employee_id, calculate_duration(issue_history, ih.start_date, to_date), ih.issue_id, report_id)
  end

  def start_date_between_the_range_and_end_date_between_the_range
    issue_history = IssueHistory.where("start_date BETWEEN ? AND ?", from_date, to_date)
                     .where("end_date BETWEEN ? AND ?", from_date, to_date)
                     .where("employee_id = ?", employee_id)
                     .where("status_id IN (?)", counted_statuses)

    save_report_result(employee_id, calculate_duration(issue_history, ih.start_date, ih.end_date), ih.issue_id, report_id)
  end

  def calculate_duration(issue_history, from_date, to_date)
    issue_history.each do |ih|
      if ReportResult.find_by(issue_id: ih.issue_id, employee_id: employee_id, report_id: report_id).nil?
        if to_date - from_date < (4 * 60 * 60)
          return (to_date - from_date)
        else
          return Time.parse(from_date.to_s).business_time_until(Time.parse(to_date.to_s))
        end
      end
    end
  end

  def save_report_result(employee_id, spent, issue_id, report_id)
    rr = ReportResult.new(employee_id: employee_id, spent: spent, issue_id: issue_id, report_id: report_id)
    rr.save!
  end
end
class ReportResultsService
  
  attr_accessor :from_date, :to_date, :employee_id, :report_id, :counted_statuses, :report_result_to_save

  def initialize(from_date, to_date, employee_id, report_id)
    self.from_date = from_date
    self.to_date = to_date
    self.employee_id = employee_id
    self.report_id = report_id
    self.counted_statuses = Array.new
    self.report_result_to_save = Array.new
    Status.where("counted = ?", true).each { |s| counted_statuses << s.id }
  end

  def set_spent_times
    record_durations
  end

  def set_calculated_work_hours
    working_days = from_date.business_days_until(to_date) #- vacation_days

    sum = ReportResult.where(:employee_id => employee_id).where(:report_id => report_id).sum(:spent)
    ReportResult.where(:employee_id => employee_id).where(:report_id => report_id).each do |rr|
      rr.calculated = rr.spent / sum * ( working_days * 5.5 )
      rr.save!
    end
  end

  private

  def record_durations
    start_date_less_than_from_date_and_end_date_is_out_of_range
    start_date_less_than_from_date_and_end_date_between_the_range
    start_date_between_the_range_and_end_date_is_out_of_range
    start_date_between_the_range_and_end_date_between_the_range
    report_result_to_save.each { |r| save_report_result(r[0], r[1], r[2]) }
  end

  def start_date_less_than_from_date_and_end_date_is_out_of_range
    issue_history = IssueHistory.where("start_date < ?", from_date)
                     .where("end_date IS NULL OR end_date > ?", to_date)
                     .where("employee_id = ?", employee_id)
                     .where("status_id IN (?)", counted_statuses)
    find_what_to_save(issue_history, from_date, to_date)
  end

  def start_date_less_than_from_date_and_end_date_between_the_range
    issue_history = IssueHistory.where("start_date < ?", from_date)
                     .where("end_date BETWEEN ? AND ?", from_date, to_date)
                     .where("employee_id = ?", employee_id)
                     .where("status_id IN (?)", counted_statuses)

    find_what_to_save(issue_history, from_date, "")
  end

  def start_date_between_the_range_and_end_date_is_out_of_range
    issue_history = IssueHistory.where("start_date BETWEEN ? AND ?", from_date, to_date)
                     .where("end_date IS NULL OR end_date > ?", to_date)
                     .where("employee_id = ?", employee_id)
                     .where("status_id IN (?)", counted_statuses)
    find_what_to_save(issue_history, "", to_date)
  end

  def start_date_between_the_range_and_end_date_between_the_range
    issue_history = IssueHistory.where("start_date BETWEEN ? AND ?", from_date, to_date)
                     .where("end_date BETWEEN ? AND ?", from_date, to_date)
                     .where("employee_id = ?", employee_id)
                     .where("status_id IN (?)", counted_statuses)
    
    find_what_to_save(issue_history, "", "")
  end

  def find_what_to_save(issue_history, from_date, to_date)
    f_date = from_date
    t_date = to_date
    issue_history.each do |ih|
      f_date = ih.start_date if from_date == ""
      t_date = ih.end_date if to_date == ""
      spent = calculate_duration(ih, f_date, t_date)
      report_result_to_save << [ih.employee_id, spent, ih.issue_id]
    end
  end

  def calculate_duration(ih, from_date, to_date)
    if ReportResult.find_by(issue_id: ih.issue_id, employee_id: employee_id, report_id: report_id).nil?
      to_date = Time.parse(to_date.to_s)
      from_date = Time.parse(from_date.to_s)
      if (to_date - from_date) < (4 * 60 * 60)
        duration = to_date - from_date
        return duration
      end
      return from_date.business_time_until(to_date)
    end
  end

  def save_report_result(employee_id, spent, issue_id)
    rr = ReportResult.where("employee_id = ?", employee_id).where("issue_id = ?", issue_id).where("report_id = ?", report_id)
    p "RR: #{rr.count}"
    if rr.empty?
      rr = ReportResult.new(employee_id: employee_id, spent: spent, issue_id: issue_id, report_id: report_id)
      rr.save!
    else 
      rr.first.spent += spent
      rr.first.save!
    end
  end
end
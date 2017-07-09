class ReportResultsService
  
  attr_accessor :from_date, :to_date, :employee_id, :report_id, :counted_statuses, :report_result_to_save, :vacations

  def initialize(from_date, to_date, employee_id, report_id)
    self.from_date = from_date
    self.to_date = to_date
    self.employee_id = employee_id
    self.report_id = report_id
    self.counted_statuses = Array.new
    self.report_result_to_save = Array.new
    self.vacations = Array.new
    Status.where("counted = ?", true).each { |s| counted_statuses << s.id }
  end

  def set_spent_times
    record_durations
  end

  def set_calculated_work_hours
    ReportResult.where(:employee_id => employee_id).where(:report_id => report_id).each do |rr|
      p "BEFORE VACATION: #{BusinessTime::Config.holidays.to_json}"
      add_vacation_to_business_time
      p "AFTER VACATION: #{BusinessTime::Config.holidays.to_json}"
      calculate_relative_time(rr)
      remove_vacation_from_business_time
      p "AFTER CALCULATION: #{BusinessTime::Config.holidays.to_json}"
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

  # I had no idea how else I can play with the dates. From_date either is the start of the report
  # or an array and comes from the matched issue_history start_dates. Same for the end date, either
  # one date, or an array of the dates which anyway was given with the `issue_history` variable.
  def find_what_to_save(issue_history, from_date, to_date)
    issue_history.each do |ih|
      from_date = ih.start_date if from_date == ""
      to_date = ih.end_date if to_date == ""
      spent = calculate_duration(ih, from_date, to_date)
      report_result_to_save << [ih.employee_id, spent, ih.issue_id]
    end
  end

  def add_vacation_to_business_time
    Vacation.where(:employee_id => employee_id).where(:report_id => report_id).each do |v| 
      v.start_date.business_dates_until(v.end_date).each do |vacation_day| 
        vacations << vacation_day
        BusinessTime::Config.holidays << vacation_day 
      end
    end
  end

  def remove_vacation_from_business_time
    vacations.each { |vacation| BusinessTime::Config.holidays.delete(vacation) }
  end

  def calculate_duration(ih, from_date, to_date)
    if ReportResult.find_by(issue_id: ih.issue_id, employee_id: employee_id, report_id: report_id).nil?
      from_date = Time.parse(from_date.to_s)
      to_date = Time.parse(to_date.to_s)
      if (to_date - from_date) < (4 * 60 * 60)
        duration = to_date - from_date
        return duration
      end
      return from_date.business_time_until(to_date)
    end
  end

  def calculate_relative_time(report_result_item)
    working_days = from_date.business_days_until(to_date) # Vacation days were added to BusinessTime
    sum = ReportResult.where(:employee_id => employee_id).where(:report_id => report_id).sum(:spent)
    overtime = 0
    Overtime.where(employee_id: report_result_item.employee_id).where("start_date BETWEEN ? AND ?", from_date, to_date).each do |o|
      if o.end_date <= to_date
        overtime = o.hours 
      else
        overtime = o.hours # TODO: add logic when the overtime is crossing through the months
      end
    end
    report_result_item.calculated = report_result_item.spent / sum * ( working_days * 5.5 )
    report_result_item.save!
  end

  def save_report_result(employee_id, spent, issue_id)
    rr = ReportResult.where(employee_id: employee_id).where(issue_id: issue_id).where(report_id: report_id)
    if rr.empty?
      rr = ReportResult.new(employee_id: employee_id, spent: spent, issue_id: issue_id, report_id: report_id)
      rr.save!
    else 
      rr.first.spent += spent
      rr.first.save!
    end
  end
end
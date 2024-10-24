class SchedulesController < ApplicationController
  def index
    # Get the start date from the parameters or default to today.
    start_date = params.fetch(:start_date, Date.today).to_date

    # Fetch shifts for a monthly view (first day of the month to the last day, adjusted by the week's boundaries)
    @shifts = Shift.where(start_time: start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week)

    # Or, for a weekly view:
    # @meetings = Meeting.where(starts_at: start_date.beginning_of_week..start_date.end_of_week)
  end
end

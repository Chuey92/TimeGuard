class SchedulesController < ApplicationController
  def index
    # Get the start date from the parameters or default to today.
    start_date = params.fetch(:start_date, Date.today).to_date

    # Fetch shifts for a monthly view (first day of the month to the last day, adjusted by the week's boundaries)
    @shifts = Shift.where(start_time: start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week)

    # Alternatively, for a weekly view (use if needed):
    # @shifts = Shift.where(start_time: start_date.beginning_of_week..start_date.end_of_week)

    # You can pass these variables to the view to show the selected date range or navigate between weeks/months.
    @start_date = start_date
  end
end
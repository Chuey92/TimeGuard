class SchedulesController < ApplicationController
  # Other actions...

  # def update_event
  #   event = find_event
  #   return unless event # Early return if event is not found

  #   if update_shift(event)
  #     render json: { success: true }
  #   else
  #     render json: { error: event.errors.full_messages }, status: :unprocessable_entity
  #   end
  # end

  # private

  # def find_event
  #   Shift.find(params[:id])
  # rescue ActiveRecord::RecordNotFound
  #   render json: { error: 'Event not found' }, status: :not_found
  #   nil # Return nil to indicate that the event was not found
  # end

  # def update_shift(event)
  #   event.update(shift_date: params[:start], end_time: params[:end]) # Adjust these fields as necessary
  # end

  # def index
  #   @schedules = Schedule.includes(:shifts) # Ensure you load the schedules with associated shifts
  # end

  def index
    # Scope your query to the dates being shown:
    start_date = params.fetch(:start_date, Date.today).to_date

    # For a monthly view:
    @shifts = Shift.where(start_time: start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week)

    # Or, for a weekly view:
    # @meetings = Meeting.where(starts_at: start_date.beginning_of_week..start_date.end_of_week)
  end
end

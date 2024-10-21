class SchedulesController < ApplicationController
  # Other actions...

  def update_event
    event = find_event
    return unless event # Early return if event is not found

    if update_shift(event)
      render json: { success: true }
    else
      render json: { error: event.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def find_event
    Shift.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Event not found' }, status: :not_found
    nil # Return nil to indicate that the event was not found
  end

  def update_shift(event)
    event.update(shift_date: params[:start], end_time: params[:end]) # Adjust these fields as necessary
  end
end

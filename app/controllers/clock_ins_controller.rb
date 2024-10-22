class ClockInsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_shift, only: [:create]

  def create
    if location_matches_site?
      @shift.update(clocked_in: true)
      redirect_to shifts_path, notice: "Clocked in successfully."
    else
      redirect_to shifts_path, alert: "You must be at the site to clock in."
    end
  end

  def new
    @upcoming_shift = current_user.shifts.where('shift_date >= ?', Date.today).order(:shift_date).first
  end

  private

  def set_shift
    @shift = Shift.find(params[:shift_id])
  end

  def location_matches_site?
    # Add your logic to verify if the user's location matches the site location
  end
end

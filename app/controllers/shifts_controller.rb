class ShiftsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_shift, only: %i[show edit update destroy clock_in]

  def index
    @shifts = policy_scope(Shift)
  end

  def show
    authorize @shift
  end

  def new
    @shift = Shift.new
    authorize @shift
  end

  def create
    @shift = Shift.new(shift_params)
    authorize @shift
    if @shift.save
      redirect_to @shift, notice: "Shift created successfully."
    else
      render :new
    end
  end

  def update
    authorize @shift
    if @shift.update(shift_params)
      redirect_to @shift, notice: "Shift updated successfully."
    else
      render :edit
    end
  end

  def edit
    authorize @shift
  end

  def destroy
    authorize @shift
    @shift.destroy
    redirect_to shifts_path, notice: "Shift deleted successfully."
  end

  def clock_in
    authorize @shift

    # Get current latitude and longitude from the user's geolocation
    user_lat = params[:latitude].to_f
    user_lon = params[:longitude].to_f

    # Retrieve the site location linked to the shift's schedule
    site = @shift.schedule.site
    site_lat = site.latitude
    site_lon = site.longitude

    # Check if user's current location matches site location within a reasonable distance (e.g., 0.5 km)
    distance = Geocoder::Calculations.distance_between([user_lat, user_lon], [site_lat, site_lon])

    if distance <= 0.5
      @shift.update(clocked_in: true)
      render json: { success: true, message: "Clocked in successfully!" }
    else
      render json: { success: false, message: "You are not at the correct site to clock in." }
    end
  end

  private

  def set_shift
    @shift = Shift.find(params[:id])
  end

  def shift_params
    params.require(:shift).permit(:user_id, :schedule_id, :shift_date, :start_time, :clocked_in, :start_time, :end_time)
  end
end

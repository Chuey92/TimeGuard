class ShiftsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_shift, only: [:show, :edit, :update, :destroy, :clock_in]

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
    @shift = Shift.find(params[:id])
    if @shift.update(shift_params)
      render json: @shift
    else
      render json: { error: @shift.errors.full_messages }, status: :unprocessable_entity
    end :edit
  end

  def destroy
    authorize @shift
    @shift.destroy
    redirect_to shifts_path, notice: "Shift deleted successfully."
  end

  def clock_in
    authorize @shift
    # Check if user's location matches the site's location
    if location_matches_site?
      @shift.update(clocked_in: true)
      redirect_to @shift, notice: "Clocked in successfully."
    else
      redirect_to @shift, alert: "You must be at the site to clock in."
    end
  end

  private

  def set_shift
    @shift = Shift.find(params[:id])
  end

  def shift_params
    params.require(:shift).permit(:user_id, :schedule_id, :shift_date, :shift_time, :clocked_in, :start_time, :end_time)
  end

  def location_matches_site?
    # Logic to check if user location matches site
  end
end

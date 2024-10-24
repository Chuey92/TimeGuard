class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @home_page = true
  end

  def dashboard
    @sites = Site.all
    @markers = @sites.geocoded.map do |site|
      {
        lat: site.latitude,
        lng: site.longitude,
        info_window_html: render_to_string(partial: "sites/info_window", locals: { site: })
      }
    end
    @next_shift = Shift.where('start_time > ?', Time.now).order(start_time: :asc).first
    @schedules = Schedule.all

    # Scope your query to the dates being shown:
    start_date = params.fetch(:start_date, Date.today).to_date

    # For a monthly view:
    # @shifts = Shift.where(start_time: start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week)

    # Or, for a weekly view:
    @shifts = Shift.where(start_time: start_date.beginning_of_week..start_date.end_of_week)
  end

  def dashboard2
    @next_shift = Shift.where('start_time > ? AND user_id = ?', Time.now, current_user.id).order(start_time: :asc).first
    # Scope your query to the dates being shown:
    start_date = params.fetch(:start_date, Date.today).to_date

    # For a monthly view:
    # @shifts = Shift.where(start_time: start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week)

    # Or, for a weekly view:
    @shifts = Shift.where(user_id: current_user.id, start_time: start_date.beginning_of_week..start_date.end_of_week)
  end
end

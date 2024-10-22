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
    @next_shift = Shift.where('shift_time > ?', Time.now).order(shift_time: :asc).first
    @schedules = Schedule.all
  end
end

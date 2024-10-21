class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @home_page = true
  end

  def dashboard
    @sites = Site.all
    @next_shift = Shift.where('shift_time > ?', Time.now).order(shift_time: :asc).first
    @schedules = Schedule.all
  end
end

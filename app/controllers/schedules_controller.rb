class SchedulesController < ApplicationController
  def index
    @schedules = Schedule.includes(:shifts) # Ensure you load the schedules with associated shifts
  end
end

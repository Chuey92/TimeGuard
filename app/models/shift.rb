class Shift < ApplicationRecord
  belongs_to :user
  belongs_to :schedule

  has_many :requests
  # validates :shift_date, :start_time, presence: true
  validates :shift_date, :start_time, :end_time, presence: true
  validate :end_time_after_start_time

  # for simple_calender
  default_scope -> { order(:start_time) }

  def time
    "#{start_time.strftime('%I:%M %p')} - #{end_time.strftime('%I:%M %p')}"
  end

  def multi_days?
    (end_time.to_date - start_time.to_date).to_i >= 1
  end
  #

  private

  def end_time_after_start_time
    return unless start_time >= end_time

    errors.add(:end_time, "must be after the start time")
  end
end

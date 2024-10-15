class Shift < ApplicationRecord
  belongs_to :user
  belongs_to :schedule

  has_many :requests
  validates :shift_date, :shift_time, presence: true
end

class Shift < ApplicationRecord
  belongs_to :user
  belongs_to :schedule

  has_many :requests
end

class Schedule < ApplicationRecord
  belongs_to :user
  belongs_to :site

  has_many :shifts
  has_many :requests
  validates :date, presence: true
end

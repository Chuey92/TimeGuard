class Site < ApplicationRecord
  belongs_to :user

  has_many :schedules
  validates :name, :address, presence: true
end

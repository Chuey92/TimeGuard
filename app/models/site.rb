class Site < ApplicationRecord
  belongs_to :user

  has_many :schedules, dependent: :destroy
  validates :name, :address, presence: true

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end

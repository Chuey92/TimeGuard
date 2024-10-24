class Site < ApplicationRecord
  belongs_to :user

  has_many :schedules, dependent: :destroy
  validates :name, :address, presence: true

  after_create :create_initial_schedule

  geocoded_by :address
  after_validation :geocode_with_error_handling, if: :will_save_change_to_address?

  private

  def geocode_with_error_handling
    begin
      geocode
    rescue StandardError => e
      Rails.logger.error "Geocoding error: #{e.message}"
      errors.add(:address, "could not be geocoded, please check the address")
    end
  end

  def create_initial_schedule
    schedules.create!(date: Date.today)
  end
end

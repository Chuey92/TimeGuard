class Site < ApplicationRecord
  belongs_to :user
  has_many :schedules, dependent: :destroy

  validates :name, :address, presence: true

  after_create :create_initial_schedules

  geocoded_by :address
  after_validation :geocode_with_error_handling, if: :will_save_change_to_address?

  def user_is_manager
    errors.add(:user, "must be a manager to create a site") unless user.manager?
  end

  private

  def geocode_with_error_handling
    begin
      geocode
    rescue StandardError => e
      Rails.logger.error "Geocoding error: #{e.message}"
      errors.add(:address, "could not be geocoded, please check the address")
    end
  end

  # Create schedules for the next 4 weeks for all users
  def create_initial_schedules
    return if schedules.exists?

    manager_users = User.where(manager: true)
    Schedule.create!(user: manager_users.first, site: self,  date: Date.today) if schedules.empty?
end
end

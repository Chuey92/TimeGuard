# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Clear out existing records to avoid duplicates during reseeding
Request.destroy_all
Shift.destroy_all
Schedule.destroy_all
Site.destroy_all
User.destroy_all
# Seed manager users
manager_users = [
  { name: "John Doe", email: "john@example.com", password: "password123", date_availability: Date.today, hours: 40, manager: true },
  { name: "Jane Smith", email: "jane@example.com", password: "password123", date_availability: Date.today, hours: 40, manager: true },
  { name: "Mike Johnson", email: "mike@example.com", password: "password123", date_availability: Date.today, hours: 40, manager: true }
]
manager_users.each do |user_data|
  User.find_or_create_by!(email: user_data[:email]) do |user|
    user.update!(user_data)
    puts "Manager user #{user_data[:name]} created successfully."
  end
end
# Seed non-manager users
non_manager_users = [
  { name: "Alice Brown", email: "alice@example.com", password: "password123", date_availability: Date.today, hours: 40, manager: false },
  { name: "Bob Wilson", email: "bob@example.com", password: "password123", date_availability: Date.today, hours: 40, manager: false }
]
non_manager_users.each do |user_data|
  User.find_or_create_by!(email: user_data[:email]) do |user|
    user.update!(user_data)
    puts "Non-manager user #{user_data[:name]} created successfully."
  end
end
# Fetch users for further usage
manager_user1 = User.find_by(email: "john@example.com")
manager_user2 = User.find_by(email: "jane@example.com")
manager_user3 = User.find_by(email: "mike@example.com")
non_manager_user1 = User.find_by(email: "alice@example.com")
non_manager_user2 = User.find_by(email: "bob@example.com")
# Create sites, link them to managers
sites = Site.create!([
  { name: "London Headquarters", address: "123 Baker St, London", user: manager_user1, latitude: 51.5216549, longitude: -0.1574937 },
  { name: "London Tech Hub", address: "456 Oxford St, London", user: manager_user2, latitude: 51.514568, longitude: -0.135611 },
  { name: "London Office Space", address: "789 Regent St, London", user: manager_user3, latitude: 51.5125346, longitude: -0.140195 }
])

# Check if latitude & longitude for sites are correct. Remove this part if not needed.
sites.each do |site|
  if site.latitude.nil? || site.longitude.nil?
    coordinates = site.geocode # Assuming geocoder works in the project setup
    site.update(latitude: coordinates[0], longitude: coordinates[1]) if coordinates.present?
  end
end

schedules = Schedule.create!([
  { user: non_manager_user1, date: Date.today, site: sites[0] },
  { user: non_manager_user2, date: Date.today + 1.week, site: sites[1] },
  { user: non_manager_user1, date: Date.today + 2.weeks, site: sites[2] }
])
# Create shifts linked to schedules and users
shifts = Shift.create!([
  { user: non_manager_user1, schedule: schedules[0], shift_date: Date.today, shift_time: "09:00", clocked_in: true },
  { user: non_manager_user2, schedule: schedules[1], shift_date: Date.today + 1.week, shift_time: "10:00", clocked_in: false },
  { user: non_manager_user1, schedule: schedules[2], shift_date: Date.today + 2.weeks, shift_time: "11:00", clocked_in: true }
])
# Create requests linked to users, shifts, and schedules
requests = Request.create!([
  { user: non_manager_user1, shift: shifts[0], schedule: schedules[0], date_of_request: Date.today - 1.day, comment: "Request shift change", request_type: "shift change", request_status: "pending" },
  { user: non_manager_user2, shift: shifts[1], schedule: schedules[1], date_of_request: Date.today + 5.days, comment: "Request time off", request_type: "time off", request_status: "approved" },
  { user: non_manager_user1, shift: shifts[2], schedule: schedules[2], date_of_request: Date.today + 10.days, comment: "Request overtime", request_type: "overtime", request_status: "pending" }
])
puts "Successfully seeded sites, schedules, shifts, and requests!"

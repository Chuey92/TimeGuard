# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


# Destroy all existing records to prevent duplicates
Request.destroy_all
Shift.destroy_all
Schedule.destroy_all
Site.destroy_all

# Define manager users with necessary fields and validations
manager_users = [
  {
    name: "John Doe",
    email: "john@example.com",
    password: "password123",
    date_availability: Date.today,
    hours: 40,
    manager: true
  },
  {
    name: "Jane Smith",
    email: "jane@example.com",
    password: "password123",
    date_availability: Date.today,
    hours: 40,
    manager: true
  },
  {
    name: "Mike Johnson",
    email: "mike@example.com",
    password: "password123",
    date_availability: Date.today,
    hours: 40,
    manager: true
  }
]

# Create the manager users
manager_users.each do |user_data|
  begin
    User.create!(user_data)
    puts "Manager user #{user_data[:name]} created successfully."
  rescue ActiveRecord::RecordInvalid => e
    puts "Failed to create manager user #{user_data[:name]}: #{e.message}"
  end
end

# Define non-manager users with necessary fields and validations
non_manager_users = [
  {
    name: "Alice Brown",
    email: "alice@example.com",
    password: "password123",
    date_availability: Date.today,
    hours: 40,
    manager: false
  },
  {
    name: "Bob Wilson",
    email: "bob@example.com",
    password: "password123",
    date_availability: Date.today,
    hours: 40,
    manager: false
  }
]

# Create the non-manager users
non_manager_users.each do |user_data|
  begin
    User.create!(user_data)
    puts "Non-manager user #{user_data[:name]} created successfully."
  rescue ActiveRecord::RecordInvalid => e
    puts "Failed to create non-manager user #{user_data[:name]}: #{e.message}"
  end
end



# Assuming your users have been created previously:
manager_user1 = User.find_by(email: "john@example.com")
manager_user2 = User.find_by(email: "jane@example.com")
manager_user3 = User.find_by(email: "mike@example.com")
non_manager_user1 = User.find_by(email: "alice@example.com")
non_manager_user2 = User.find_by(email: "bob@example.com")

# Create sites in London associated with a manager
sites = Site.create!([
  { name: "London Headquarters", address: "123 Baker St, London", user: manager_user1 },
  { name: "London Tech Hub", address: "456 Oxford St, London", user: manager_user2 },
  { name: "London Office Space", address: "789 Regent St, London", user: manager_user3 }
])

# Create schedules for the non-manager users
schedules = Schedule.create!([
  { user: non_manager_user1, date: Date.today, site: sites[0] },
  { user: non_manager_user2, date: Date.today + 1.week, site: sites[1] },
  { user: non_manager_user1, date: Date.today + 2.weeks, site: sites[2] }
])

# Create shifts linked to the schedules
shifts = Shift.create!([
  { user: non_manager_user1, schedule: schedules[0], shift_date: Date.today, shift_time: "09:00", clocked_in: true },
  { user: non_manager_user2, schedule: schedules[1], shift_date: Date.today + 1.week, shift_time: "10:00", clocked_in: false },
  { user: non_manager_user1, schedule: schedules[2], shift_date: Date.today + 2.weeks, shift_time: "11:00", clocked_in: true }
])

# Create requests linked to users, shifts, and schedules
requests = Request.create!([
  { user: non_manager_user1, shift: shifts[0], schedule: schedules[0], date_of_request: Date.today - 1.day, comment: "Request shift change", request_type: "Shift Change", request_status: "Pending" },
  { user: non_manager_user2, shift: shifts[1], schedule: schedules[1], date_of_request: Date.today + 5.days, comment: "Request time off", request_type: "Time Off", request_status: "Approved" },
  { user: non_manager_user1, shift: shifts[2], schedule: schedules[2], date_of_request: Date.today + 10.days, comment: "Request overtime", request_type: "Overtime", request_status: "Pending" }
])

puts "Successfully seeded sites, schedules, shifts, and requests!"

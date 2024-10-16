# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


# db/seeds.rb

# First, let's make sure we don't create duplicate users if we run seeds multiple times
User.destroy_all

# Create manager users
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
  User.create!(user_data)
end

# Optionally, you can also create some non-manager users
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
  User.create!(user_data)
end

puts "Created #{User.count} users (#{User.where(manager: true).count} managers)"

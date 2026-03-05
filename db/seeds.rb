# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


# Chats and User
# 1. Clean the database 🗑️
puts
puts
puts "---- Chats ----"
puts "Cleaning database..."
Chat.destroy_all
User.find_by(email: "guest@gmail.com").destroy unless User.find_by(email: "guest@gmail.com").nil?

# 2. Create the instances 🏗️
chat = Chat.new(title: "Finding cat names")

user = User.create!(email: "guest@gmail.com", password: "123123" , password_confirmation: "123123", name: "guest")
chat.user = user
chat.save

# 3. Display a message 🎉
puts "Finished! Created #{Chat.count} chat(s)."
puts
puts

# Category
# 1. Clean the database 🗑️
puts
puts
puts "---- Categories ----"
puts "Cleaning database..."
Category.destroy_all

# 2. Create the instances 🏗️
categories = [
  "Coding & Development",
  "Writing & Content",
  "Business & Strategy",
  "Marketing & Sales",
  "Data & Analysis",
  "Education & Learning",
  "Science & Research",
  "Legal & Compliance",
  "Finance & Accounting",
  "Health & Wellness",
  "Design & Creative",
  "Career & Professional Development",
  "Travel & Lifestyle"
]
categories.each do |cat|
  Category.create!(name: cat, system_prompt: "system_prompt")
end

# 3. Display a message 🎉
puts "Finished! Created #{Category.count} category."
puts
puts

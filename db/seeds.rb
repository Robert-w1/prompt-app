# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


# Category
# 1. Clean the database 🗑️
puts
puts
puts "---- Categories ----"
puts "Cleaning database..."
Category.destroy_all

# 2. Create the instances 🏗️
Category.create!(name: "Funny", system_prompt: "Always start your answers to my prompt with a little joke.")

# 3. Display a message 🎉
puts "Finished! Created #{Category.count} category."
puts
puts

# Chats
# 1. Clean the database 🗑️
puts
puts
puts "---- Chats ----"
puts "Cleaning database..."
Chat.destroy_all

# 2. Create the instances 🏗️
# User.create!(name: "guest", email: "guest@gmail.com", )
chat = Chat.new(title: "Finding cat names")
user = User.create!(email: "guest123@gmail.com", password: "123123" , password_confirmation: "123123", name: "guest")
chat.user = user
chat.save

5.times do |i|
  project = Project.new
  project.name = "Project #{i}"
  project.description = "Desc #{i}"
  project.user = user
  project.save
end

# 3. Display a message 🎉
puts "Finished! Created #{Chat.count} category."
puts
puts

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

puts "🌱 Seeding database..."

# Create admin user if it doesn't exist
admin_user = User.find_or_create_by!(email: "admin@dentalbolivia.com") do |user|
  user.name = "Administrador"
  user.role = "admin"
  user.password = "password123"
  user.password_confirmation = "password123"
end

puts "✅ Admin user created: #{admin_user.email}"

# Create sample dentists
dentist1 = User.find_or_create_by!(email: "carlos.mendoza@dentalbolivia.com") do |user|
  user.name = "Dr. Carlos Mendoza"
  user.role = "dentist"
  user.specialty = "Implantología"
  user.password = "password123"
  user.password_confirmation = "password123"
end

dentist2 = User.find_or_create_by!(email: "ana.rodriguez@dentalbolivia.com") do |user|
  user.name = "Dra. Ana Rodríguez"
  user.role = "dentist"
  user.specialty = "Ortodoncia"
  user.password = "password123"
  user.password_confirmation = "password123"
end

dentist3 = User.find_or_create_by!(email: "luis.vargas@dentalbolivia.com") do |user|
  user.name = "Dr. Luis Vargas"
  user.role = "dentist"
  user.specialty = "Odontopediatría"
  user.password = "password123"
  user.password_confirmation = "password123"
end

puts "✅ Dentists created: #{[dentist1, dentist2, dentist3].map(&:name).join(', ')}"

# Create receptionist
receptionist = User.find_or_create_by!(email: "recepcion@dentalbolivia.com") do |user|
  user.name = "María Gonzales"
  user.role = "receptionist"
  user.password = "password123"
  user.password_confirmation = "password123"
end

puts "✅ Receptionist created: #{receptionist.name}"

puts "🎉 Database seeded successfully!"
puts ""
puts "📋 Login credentials:"
puts "Admin: admin@dentalbolivia.com / password123"
puts "Dentist 1: carlos.mendoza@dentalbolivia.com / password123"
puts "Dentist 2: ana.rodriguez@dentalbolivia.com / password123"
puts "Dentist 3: luis.vargas@dentalbolivia.com / password123"
puts "Receptionist: recepcion@dentalbolivia.com / password123"

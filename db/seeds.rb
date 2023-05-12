# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create(
  name: 'admin',
  email: 'admin@admin.com',
  password: 'admin123',
  phone: '',
  document: '',
  roles: ['master']
)

10.times do
  User.create(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: '123123123',
    phone: Faker::PhoneNumber.cell_phone,
    document: Faker::IDNumber.brazilian_citizen_number,
    roles: []
  )
end


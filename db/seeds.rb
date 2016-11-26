# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Role.create([{name: 'admin'}, {name: 'user'}])
admin_role, user_role = Role.find_by(name: 'admin'), Role.find_by(name: 'user')

User.create([{name: 'admin', email: "admin@foo.bar", password: 'password123', role: admin_role},
            {name: 'Gregor Clegane', email: "gregor@got.com", password: 'password123', role: admin_role},
            {name: 'Tywin Lannister', email: "tywin@got.com", password: 'password123', role: admin_role},
            {name: 'Jon Snow', email: "jon@got.com", password: 'password123', role: admin_role},
            {name: 'visitor123', password: 'password123'}])



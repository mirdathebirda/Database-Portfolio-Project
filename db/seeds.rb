# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Role.create([{name: 'admin'}, {name: 'user'}])
admin_role, user_role = Role.find_by(name: 'admin').id, Role.find_by(name: 'user').id

users = [{name: 'admin', email: "admin@foo.bar", password: 'password123'},
          {name: 'Gregor Clegane', email: "gregor@got.com", password: 'password123'},
          {name: 'Tywin Lannister', email: "tywin@got.com", password: 'password123'},
          {name: 'Jon Snow', email: "jon@got.com", password: 'password123'},
          {name: 'visitor123', password: 'password123'}]
User.create(users)

user_ids = users.map{|user| User.find_by(name: user[:name]).id}

User.connection.execute "INSERT INTO user_role (user, role) VALUES (#{user_ids[0]}, #{admin_role});"
(1..3).to_a.each do |i|
  User.connection.execute "INSERT INTO user_role (user, role) VALUES (#{user_ids[i]}, #{user_role});"
end



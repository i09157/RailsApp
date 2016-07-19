# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

@user = User.new
@user.name = 'kisuke'
@user.score = '100'
@user.win = 1.0
@user.lose = 1.0
@user.draw = 1.0
@user.pass = 'kisuke'
@user.save

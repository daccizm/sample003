# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create([
	{ account: 'Tarou', password: 'tarou001', password_confirmation: 'tarou001', email: 'tarou@gmail.com'},
	{ account: 'Hanako', password: 'hanako001', password_confirmation: 'hanako001', email: 'hanako@gmail.com'},
])
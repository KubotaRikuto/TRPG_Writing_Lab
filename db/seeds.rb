# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# trpg_rules
require "csv"

CSV.foreach('db/TRPGtitle.csv',headers: true) do |row|
  TrpgRule.create(title: row['TRPG_title'])
end
# adminID
Admin.create!(email: '610.9bt@gmail.com',password: 'zeU3tzMN77AU' )

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Rake::Task["csv_load:all"].invoke

@discount1 = Discount.create(percent_discount: 0.10, threshold: 4, merchant_id: 1)
@discount2 = Discount.create(percent_discount: 0.05, threshold: 6, merchant_id: 1)
@discount3 = Discount.create(percent_discount: 0.25, threshold: 9, merchant_id: 1)
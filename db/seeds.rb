# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Category.create(name: "Main Dish")
Category.create(name: "Fried")

MenuItem.create(name: "Nasi Uduk", description: "Nasi with Betawi style",price: 15000)
MenuItem.create(name: "Nasi Goreng", description: "Fried Rice with Kecap", price: 15000)

MenuCategory.create(menu_item_id: 1, category_id: 1)
MenuCategory.create(menu_item_id: 1, category_id: 2)

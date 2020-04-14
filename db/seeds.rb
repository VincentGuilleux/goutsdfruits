

# require "open-uri"

Client.destroy_all
Order.destroy_all
User.destroy_all
Order_line.destroy_all
Order_line_product_lot.destroy_all
Product.destroy_all
Product_lot.destroy_all


# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# ==> model name
# client
# order
# order_line
# order_line_product_lot
# product
# product_lot
# user


# 1 - Create "client"
# 2 - create "product"
# 3 - Create "order"

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
client1 = Client.create(first_name: "Sébastien", last_name:"Etienne", email:"sebastien@gmail.com", phone:"0654789654", address:"Le Plessis",post_code:"79140", city:"Cerizay")
client2 = Client.create(first_name: "Anne", last_name:"Mabire", email:"anne@gmail.com", phone:"", address:"",post_code:"", city:"")
client3 = Client.create(first_name: "Maud", last_name:"De La Gourmerie", email:"", phone:"", address:"",post_code:"", city:"")
client4 = Client.create(first_name: "Vincent", last_name:"GUilleux", email:"", phone:"", address:"",post_code:"", city:"")
client5 = Client.create(first_name: "", last_name:"", email:"", phone:"", address:"",post_code:"", city:"")
client6 = Client.create(first_name: "", last_name:"", email:"", phone:"", address:"",post_code:"", city:"")
client7 = Client.create(first_name: "", last_name:"", email:"", phone:"", address:"",post_code:"", city:"")
client8 = Client.create(first_name: "", last_name:"", email:"", phone:"", address:"",post_code:"", city:"")
client9 = Client.create(first_name: "", last_name:"", email:"", phone:"", address:"",post_code:"", city:"")
client9 = Client.create(first_name: "", last_name:"", email:"", phone:"", address:"",post_code:"", city:"")
# 2 - create "product"

product1 = Product.new(name:"",description:"", units_price_cents: ,)

# 3 - Create "order"

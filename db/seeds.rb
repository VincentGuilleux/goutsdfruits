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
client1 = Client.create!(first_name: "Sébastien", last_name:"Etienne", email:"sebastien@gmail.com", phone:"0654789654", address:"Le Plessis",post_code:"79140", city:"Cerizay")
client2 = Client.create(first_name: "Anne", last_name:"Mabire", email:"anne@gmail.com", phone:"0656529654", address:"19 Avenue du Général Marigny",post_code:"79140", city:"Cerizay")
client3 = Client.create(first_name: "Maud", last_name:"De La Gourmerie", email:"maud@gmail.com", phone:"0656526341", address:"La Vannelière",post_code:"79140", city:"Cerizay")
client4 = Client.create(first_name: "Vincent", last_name:"Guilleux", email:"vincent@gmail.com", phone:"0764215846", address:"3 rue des matous",post_code:"79140", city:"Combrand")
client5 = Client.create(first_name: "Benoît", last_name:"Poelvorde", email:"benoît@gmail.com", phone:"0635874598", address:"47 allées des Mimosas",post_code:"79700", city:"Saint-Amand-sur-Sèvre")
client6 = Client.create(first_name: "Guillaume", last_name:"Canet", email:"guillaume@gmail.com", phone:"0789642531", address:"rue des moines",post_code:"85700", city:"Les Châtelliers-Châteaumur")
client7 = Client.create(first_name: "Magalie", last_name:"Jean", email:"magalie@gmail.com", phone:"0685469720", address:"rue des prés",post_code:"79140", city:"Belle-feuille")
client8 = Client.create(first_name: "Claudine", last_name:"Magen", email:"claudine@gmail.com", phone:"0687649520", address:"boulevard montfeuil",post_code:"79220", city:"La bas")
client9 = Client.create(first_name: "Gad", last_name:"Elmaleh", email:"gad@gmail.com", phone:"0789654236", address:"rue adolphe le bail",post_code:"78500", city:"Loin")
client9 = Client.create(first_name: "Mélanie", last_name:"Bouldu", email:"mélanie@gmail.com", phone:"0685976433", address:"rue du disc-jokey",post_code:"79530", city:"Brest")
client9 = Client.create(first_name: "Lucie", last_name:"Azquia", email:"lucie@gmail.com", phone:"0674548599", address:"rue des prés",post_code:"79100", city:"Breux")
# 2 - create "product"

# product1 = Product.new(name:"",description:"", units_price_cents: ,unit_type:"",product_fruit: "", product_type:"", product_category:"")
# product1.photo.attach(io: File.open(Rails.root.join('db/fixtures/')), filename: '.png', content_type: 'image/png')

product1 = Product.new(name:"Cerises",description:"Cerises en sirop", units_price_cents: 800 ,unit_type:"pot",product_fruit: "", product_type:"", product_category:"")
product1.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/cerises.jpg')), filename: 'cerises.jpg', content_type: 'image/jpg')
product1.save!

product2 = Product.new(name:"",description:"", units_price_cents: ,unit_type:"",product_fruit: "", product_type:"", product_category:"")
# product1.photo.attach(io: File.open(Rails.root.join('db/fixtures/')), filename: '.png', content_type: 'image/png')
product3 = Product.new(name:"",description:"", units_price_cents: ,unit_type:"",product_fruit: "", product_type:"", product_category:"")
# product1.photo.attach(io: File.open(Rails.root.join('db/fixtures/')), filename: '.png', content_type: 'image/png')
product4 = Product.new(name:"",description:"", units_price_cents: ,unit_type:"",product_fruit: "", product_type:"", product_category:"")
# product1.photo.attach(io: File.open(Rails.root.join('db/fixtures/')), filename: '.png', content_type: 'image/png')
product5 = Product.new(name:"",description:"", units_price_cents: ,unit_type:"",product_fruit: "", product_type:"", product_category:"")
# product1.photo.attach(io: File.open(Rails.root.join('db/fixtures/')), filename: '.png', content_type: 'image/png')
product6 = Product.new(name:"",description:"", units_price_cents: ,unit_type:"",product_fruit: "", product_type:"", product_category:"")
# product1.photo.attach(io: File.open(Rails.root.join('db/fixtures/')), filename: '.png', content_type: 'image/png')
product7 = Product.new(name:"",description:"", units_price_cents: ,unit_type:"",product_fruit: "", product_type:"", product_category:"")
# product1.photo.attach(io: File.open(Rails.root.join('db/fixtures/')), filename: '.png', content_type: 'image/png')
product8 = Product.new(name:"",description:"", units_price_cents: ,unit_type:"",product_fruit: "", product_type:"", product_category:"")
# product1.photo.attach(io: File.open(Rails.root.join('db/fixtures/')), filename: '.png', content_type: 'image/png')
product9 = Product.new(name:"",description:"", units_price_cents: ,unit_type:"",product_fruit: "", product_type:"", product_category:"")
# product1.photo.attach(io: File.open(Rails.root.join('db/fixtures/')), filename: '.png', content_type: 'image/png')
product10 = Product.new(name:"",description:"", units_price_cents: ,unit_type:"",product_fruit: "", product_type:"", product_category:"")
# product1.photo.attach(io: File.open(Rails.root.join('db/fixtures/')), filename: '.png', content_type: 'image/png')

# 3 - Create "order"

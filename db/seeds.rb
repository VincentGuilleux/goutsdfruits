require "open-uri"

OrderLineProductLot.destroy_all
ProductLot.destroy_all
OrderLine.destroy_all
Order.destroy_all
Client.destroy_all
Product.destroy_all
User.destroy_all


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

user_admin = User.create!(email: 'marie@gmail.com', password: 'azerty') #name: 'Marie' , address: "L'Orgerie, 79140 Le Pin" n'est pas déclaré dans le schéma de D
user_admin.avatar.attach(io: File.open(Rails.root.join('db/fixtures/users/madame-gazeau.jpg')), filename: 'madame-gazeau.jpg', content_type: 'image/jpg')
user_admin.save!

puts "      |    /|     - user done"

# 1 - Create "client"
client1 = Client.create!(first_name: "Amanda", last_name:"Griffin", email:"sebastien@gmail.com", phone:"0654789654", address:"Le Plessis",post_code:"79140", city:"Cerizay")
client2 = Client.create!(first_name: "Anne", last_name:"Charbonneau", email:"anne@gmail.com", phone:"0656529654", address:"19 Avenue du Général Marigny",post_code:"79140", city:"Cerizay")
client3 = Client.create!(first_name: "Clément", last_name:"Ferréol", email:"maud@gmail.com", phone:"0656526341", address:"La Vannelière",post_code:"79140", city:"Cerizay")
client4 = Client.create!(first_name: "Tanguy", last_name:" Gabriaux", email:"vincent@gmail.com", phone:"0764215846", address:"3 rue des matous",post_code:"79140", city:"Combrand")
client5 = Client.create!(first_name: "Benoît", last_name:"Peppin", email:"benoît@gmail.com", phone:"0635874598", address:"47 allées des Mimosas",post_code:"79700", city:"Saint-Amand-sur-Sèvre")
client6 = Client.create!(first_name: "Romain", last_name:"Brault", email:"guillaume@gmail.com", phone:"0789642531", address:"rue des moines",post_code:"85700", city:"Les Châtelliers-Châteaumur")
client7 = Client.create!(first_name: "Magalie", last_name:"Chalifour", email:"magalie@gmail.com", phone:"0685469720", address:"rue des prés",post_code:"79140", city:"Belle-feuille")
client8 = Client.create!(first_name: "Claudine", last_name:"Magen", email:"claudine@gmail.com", phone:"0687649520", address:"boulevard montfeuil",post_code:"79220", city:"La bas")
client9 = Client.create!(first_name: "Dominique", last_name:"Charpie", email:"gad@gmail.com", phone:"0789654236", address:"rue adolphe le bail",post_code:"78500", city:"Loin")
client10 = Client.create!(first_name: "Mélanie", last_name:"Bouldu", email:"mélanie@gmail.com", phone:"0685976433", address:"rue du disc-jokey",post_code:"79530", city:"Brest")
client11 = Client.create!(first_name: "Lucie", last_name:"Azquia", email:"lucie@gmail.com", phone:"0674548599", address:"rue des prés",post_code:"79100", city:"Breux")
client12 = Client.create!(first_name: "Marché", last_name:"des Halles", email:"", phone:"", address:"rue Brisson",post_code:"79000", city:"Niort")

puts "       )  ( ') - client done"

# 2 - create "product"

# product1 = Product.new(name:"",description:"", units_price_cents: ,unit_type:"",product_fruit: "", product_type:"", product_category:"")
# product1.photo.attach(io: File.open(Rails.root.join('db/fixtures/')), filename: '.png', content_type: 'image/png')

# product_category: Fruit frais / Gourmandise / Pépinière
# product fruit: le fruit de base
# product_type: biscuit/bocal/compote/coulis/fruit/gelée/pâte de fruits/sirop/sorbet/tartelette/végétal
# unit_type: bouteille/kg/plant/pot/sachet/

#les sorbets

product1 = Product.new(name:"Sorbet fraise",description:"Gouts d'Fruits vous offre le meilleur du sorbet fraise à travers une recette authentique et gourmande, pour votre plus grand plaisir !", unit_price_cents: 800, unit_type:"pot", product_fruit: "fraise", product_type:"sorbet", product_category:"Gourmandise")
product1.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/sorbets.jpg')), filename: 'sorbets.jpg', content_type: 'image/jpg')
product1.save!

product2 = Product.new(name:"Sorbet framboise",description:"Gouts d'Fruits vous offre le meilleur du sorbet framboise à travers une recette authentique et gourmande, pour votre plus grand plaisir !", unit_price_cents: 800, unit_type:"pot", product_fruit: "framboise", product_type:"sorbet", product_category:"Gourmandise")
product2.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/sorbet-framboise.jpg')), filename: 'sorbet-framboise.jpg', content_type: 'image/jpg')
product2.save!


product3 = Product.new(name:"Sorbet mûres",description:"Gouts d'Fruits vous offre le meilleur du sorbet mûres à travers une recette authentique et gourmande, pour votre plus grand plaisir !", unit_price_cents: 800, unit_type:"pot", product_fruit: "mûre", product_type:"sorbet", product_category:"Gourmandise")
product3.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/sorbetmures.jpg')), filename: 'sorbetmures.jpg', content_type: 'image/jpg')
product3.save!


#les tartelettes

product4 = Product.new(name:"Tartelette aux mirabelles",description:"Gouts d'Fruits vous offre le meilleur de la tartelette aux mirabelles à travers une recette authentique et gourmande, pour votre plus grand plaisir !", unit_price_cents: 300, unit_type:"sachet", product_fruit: "mirabelle", product_type:"tartelette", product_category:"Gourmandise")
product4.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/tartelette.jpg')), filename: 'tartelette.jpg', content_type: 'image/jpg')
product4.save!

#les gelées

product5 = Product.new(name:"Gelée de pommes au sureau",description:"Gout's Fruit vous offre le meilleur de la Gelée de pomme et sureau à travers une recette authentique et gourmande, pour votre plus grand plaisir, tout simplement !", unit_price_cents: 600 ,unit_type:"pot",product_fruit: "pomme", product_type:"gelée", product_category:"Gourmandise")
product5.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/gelée.jpg')), filename: 'gelée.jpg', content_type: 'image/jpg')
product5.save!

puts "      (  /  )  - product 1/5"
product6 = Product.new(name:"Gelée de groseilles",description:"Une recette fondante réalisée avec le jus de deux fruits rouges du jardin qui se marient parfaitement pour un goût frais et gourmand", unit_price_cents: 600 ,unit_type:"pot",product_fruit: "groseille", product_type:"gelée", product_category:"Gourmandise")
product6.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/gelee-groseille.jpg')), filename: 'gelee-groseille.jpg', content_type: 'image/jpg')
product6.save!

product7 = Product.new(name:"Gelée de mûres",description:"Une recette fondante réalisée avec le jus de deux fruits rouges du jardin qui se marient parfaitement pour un goût frais et gourmand", unit_price_cents: 600 ,unit_type:"pot",product_fruit: "mûre", product_type:"gelée", product_category:"Gourmandise")
product7.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/geleemures.jpg')), filename: 'geleemures.jpg', content_type: 'image/jpg')
product7.save!

product8 = Product.new(name:"Gelée de coings",description:"Gout's Fruit vous offre le meilleur de la Gelée de Coings à travers une recette authentique et gourmande, pour votre plus grand plaisir, tout simplement !", unit_price_cents: 600 ,unit_type:"pot",product_fruit: "coing", product_type:"gelée", product_category:"Gourmandise")
product8.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/gelee-coing.jpg')), filename: 'gelee-coing', content_type: 'image/jpg')
product8.save!

#les sirops

product9 = Product.new(name:"Sirop de menthe",description:"Retrouvez les saveurs rafraichissantes dans une boisson légère à diluer selon les goûts.", unit_price_cents: 700, unit_type:"bouteille", product_fruit: "menthe", product_type:"sirop", product_category:"Gourmandise")
product9.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/siropmenthe.jpg')), filename: 'siropmenthe.jpg', content_type: 'image/jpg')
product9.save!

product10 = Product.new(name:"Sirop de sureau",description:"Retrouvez les saveurs rafraichissantes dans une boisson légère à diluer selon les goûts.", unit_price_cents: 700, unit_type:"bouteille", product_fruit: "sureau", product_type:"sirop", product_category:"Gourmandise")
product10.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/siropsureau.jpg')), filename: 'siropsureau.jpg', content_type: 'image/jpg')
product10.save!
puts "       |(__)|   - product 2/5"

product11 = Product.new(name:"Sirop de fraise",description:"Retrouvez les saveurs rafraichissantes dans une boisson légère à diluer selon les goûts.", unit_price_cents: 700, unit_type:"bouteille", product_fruit: "fraise", product_type:"sirop", product_category:"Gourmandise")
product11.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/sirop-fraise.jpg')), filename: 'sirop-fraise.jpg', content_type: 'image/jpg')
product11.save!

#les compotes
product12 = Product.new(name:"Compote de pommes",description:"Goûts d’Fruits marie dans ses compotes la douceur de la pomme à la saveur des autres fruits du vergers.", unit_price_cents: 500 ,unit_type:"pot",product_fruit: "pomme", product_type:"compote", product_category:"Gourmandise")
product12.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/compote.jpg')), filename: 'compote.jpg', content_type: 'image/jpg')
product12.save!

#les biscuits
product13 = Product.new(name:"Financier aux framboises",description:"Goûts d’Fruits peut préparer pour vous de délicieux financiers à la framboise,  ou tout autre gâteau fruité sur commande.", unit_price_cents: 700 ,unit_type:"sachet",product_fruit: "framboise", product_type:"biscuit", product_category:"Gourmandise")
product13.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/financiers.jpg')), filename: 'financiers.jpg', content_type: 'image/jpg')
product13.save!

#les coulis
product14 = Product.new(name:"Coulis de framboises",description:"Coulis de framboises", unit_price_cents: 800 ,unit_type:"pot",product_fruit: "framboise", product_type:"coulis", product_category:"Gourmandise")
product14.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/coulisframboise.jpg')), filename: 'coulisframboise.jpg', content_type: 'image/jpg')
product14.save!

product15 = Product.new(name:"Coulis de cassis",description:"Testez le nappage de coulis de cassis sur vos yaourts ou gâteaux au chocolat. Moins sucré qu’une confiture, sa saveur est à découvrir d’urgence !", unit_price_cents: 800 ,unit_type:"pot",product_fruit: "cassis", product_type:"coulis", product_category:"Gourmandise")
product15.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/coulis-cassis.jpg')), filename: 'coulis-cassis.jpg', content_type: 'image/jpg')
product15.save!
puts "cat's team     - product 3/5"

product16 = Product.new(name:"Coulis de mûres",description:"Testez le nappage de coulis de mûres sur vos yaourts ou gâteaux au chocolat. Moins sucré qu’une confiture, sa saveur est à découvrir d’urgence !", unit_price_cents: 800 ,unit_type:"pot",product_fruit: "mûre", product_type:"coulis", product_category:"Gourmandise")
product16.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/coulis-mure.jpg')), filename: 'coulis.jpg', content_type: 'image/jpg')
product16.save!

#les pâtes de fruits
product17 = Product.new(name:"Pâte de fruits au cassis",description:"Faites plaisir à toute la famille avec des pâtes de fruits, vendues en sachets aux multiples saveurs.", unit_price_cents: 800 ,unit_type:"sachet",product_fruit: "cassis", product_type:"pâte de fruits", product_category:"Gourmandise")
product17.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/pates-de-fruits.jpg')), filename: 'pates-de-fruits.jpg', content_type: 'image/jpg')
product17.save!


#les fruits en sirop
product18 = Product.new(name:"Cerises en sirop",description:"Pour vos salades ou clafoutis, les bocaux préservent toutes les saveurs des fruits cueillis à maturité.", unit_price_cents: 800, unit_type:"pot", product_fruit: "cerise", product_type:"fruit au sirop", product_category:"Gourmandise")
product18.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/cerises.jpg')), filename: 'cerises.jpg', content_type: 'image/jpg')
product18.save!


#les fruits frais


product19 = Product.new(name:"Cerises",description:"Rouge vif, noire ou blanche, laissez-vous tenter par le goût subtil des premiers fruits de l’année.", unit_price_cents: 900,unit_type:"kg",product_fruit: "cerise", product_type:"fruit", product_category:"Fruit frais")
product19.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/cherry.jpg')), filename: 'cherry.jpg', content_type: 'image/jpg')
product19.save!

product20 = Product.new(name:"Fraises",description:"Fraises fraîches en barquettes", unit_price_cents: 500, unit_type:"kg",product_fruit: "fraise", product_type:"fruit", product_category:"Fruit frais")

product20.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/fraises.jpg')), filename: 'fraises.jpg', content_type: 'image/jpg')
product20.save!
puts "product 4/5"

product21 = Product.new(name:"Prunes",description:"Pour vos tartes, bocaux ou pour picorer, profitez des prunes gorgées de soleil.", unit_price_cents: 300, unit_type:"kg",product_fruit: "prune", product_type:"fruit", product_category:"Fruit frais")
product21.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/prunes.jpg')), filename: 'fraises.jpg', content_type: 'image/jpg')
product21.save!

#les plants

product22 = Product.new(name:"Plant de cassis",description:"Pour assouvir votre gourmandise et votre envie de nature, Goûts d’Fruits développe une pépinière et propose de vous accompagner dans l’aménagement de votre jardin.", unit_price_cents: 4500,unit_type:"plant",product_fruit: "cassis", product_type:"végétal", product_category:"Pépinière")
product22.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/petit-plant.jpg')), filename: 'petit-plant.jpg', content_type: 'image/jpg')
product22.save!

#les grand plants

product23 = Product.new(name:"Pommier",description:"Pour assouvir votre gourmandise et votre envie de nature, Goûts d’Fruits développe une pépinière et propose de vous accompagner dans l’aménagement de votre jardin.", unit_price_cents: 9000,unit_type:"plant",product_fruit: "pomme", product_type:"végétal", product_category:"Pépinière")
product23.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/grand-plant.jpg')), filename: 'grand-plant.jpg', content_type: 'image/jpg')
product23.save!
puts "product done"


# 4 - Create "order" 4 status / pending / prepared / delivered / paid
#création de commandes "completed" pour calcul statistique
order1 = Order.create!(client_id: client2.id ,date: Date.new(2020,4,21) ,total_price_cents: 4000 ,status:"paid", payment_method:"cash",created_at:"2020-04-21")
order2 = Order.create!(client_id: client3.id ,date: Date.new(2020,4,20) ,total_price_cents: 10800 ,status:"paid", payment_method:"cash",created_at:"2020-04-20")
#création d'une commande avec + order_lines en attente
order3 = Order.create!(client_id: client4.id ,date: Date.new(2020,4,23) ,total_price_cents: 16200 ,status:"pending",created_at:"2020-04-23")
order4 = Order.create!(client_id: client5.id ,date: Date.new(2020,4,22) ,total_price_cents: 3200 ,status:"prepared",created_at:"2020-04-22")
order5 = Order.create!(client_id: client6.id ,date: Date.new(2020,4,18) ,total_price_cents: 3200 ,status:"delivered",created_at:"2020-04-18")
order6 = Order.create!(client_id: client7.id ,date: Date.new(2020,4,16) ,total_price_cents: 4000 ,status:"delivered", created_at:"2020-04-16")
order7 = Order.create!(client_id: client8.id ,date: Date.new(2020,4,16) ,total_price_cents: 4500 ,status:"delivered", created_at:"2020-04-16")
order8 = Order.create!(client_id: client9.id ,date: Date.new(2020,4,16) ,total_price_cents: 3000 ,status:"delivered", created_at:"2020-04-16")
order9 = Order.create!(client_id: client10.id ,date: Date.new(2020,4,16) ,total_price_cents: 5400 ,status:"delivered", created_at:"2020-04-16")

puts "orders done"

# 5 - Create "order_lines" pour les 6 orders plus haut
#order1
order_line1 = OrderLine.create!(order_id: order1.id ,product_id: product2.id, quantity: 5 ,total_price_cents: 4000)

#création d'1 order avec 3 order_line  #order2
order_line2 = OrderLine.create!(order_id: order2.id ,product_id: product2.id, quantity: 10 ,total_price_cents: 8000)
order_line3 = OrderLine.create!(order_id: order2.id ,product_id: product3.id, quantity: 2 ,total_price_cents: 1600)
order_line4 = OrderLine.create!(order_id: order2.id ,product_id: product4.id, quantity: 4 ,total_price_cents: 1200)

#création d'1 order avec 4 order_line
order_line5 = OrderLine.create!(order_id: order3.id ,product_id: product22.id, quantity: 1 ,total_price_cents: 4500) #petit plant
order_line6 = OrderLine.create!(order_id: order3.id ,product_id: product23.id, quantity: 1 ,total_price_cents: 9000) #grand plant
order_line7 = OrderLine.create!(order_id: order3.id ,product_id: product13.id, quantity: 1 ,total_price_cents: 700) # financiers
order_line8 = OrderLine.create!(order_id: order3.id ,product_id: product12.id, quantity: 4 ,total_price_cents: 2000) # compote de pomme
# création d'un order prepared
order_line9 = OrderLine.create!(order_id: order4.id ,product_id: product1.id, quantity: 4 ,total_price_cents: 3200)
# création d'un order delivered
order_line10 = OrderLine.create!(order_id: order5.id ,product_id: product17.id, quantity: 2 ,total_price_cents: 1600)
order_line11 = OrderLine.create!(order_id: order5.id ,product_id: product18.id, quantity: 2 ,total_price_cents: 1600)

order_line12 = OrderLine.create!(order_id: order6.id ,product_id: product10.id, quantity: 2 ,total_price_cents: 1400)

order_line13 = OrderLine.create!(order_id: order7.id ,product_id: product10.id, quantity: 64,total_price_cents: 1400)
order_line14 = OrderLine.create!(order_id: order8.id ,product_id: product6.id, quantity: 43,total_price_cents: 1400)
order_line15 = OrderLine.create!(order_id: order9.id ,product_id: product15.id, quantity: 52,total_price_cents: 1400)




puts "order_line done"


# 6 - create "product_lots"
# création d'un lot pour chaque produit en stock
product_lot1 = ProductLot.create!(product_id: product1.id ,production_date: Date.new(2020,3,1) ,expiry_date: Date.new(2020,9,1), quantity: 50, remaining_quantity: 45, lot_number: "20041")
product_lot2 = ProductLot.create!(product_id: product2.id ,production_date: Date.new(2020,3,15) ,expiry_date: Date.new(2020,8,15), quantity: 15, remaining_quantity: 10, lot_number: "20042")
product_lot3 = ProductLot.create!(product_id: product3.id ,production_date: Date.new(2020,3,20) ,expiry_date: Date.new(2020,8,20), quantity: 10, remaining_quantity: 8, lot_number: "20043")
product_lot3bis = ProductLot.create!(product_id: product3.id ,production_date: Date.new(2020,3,21) ,expiry_date: Date.new(2020,8,21), quantity: 4, remaining_quantity: 4, lot_number: "20043")
product_lot4 = ProductLot.create!(product_id: product4.id ,production_date: Date.new(2020,3,25) ,expiry_date: Date.new(2020,5,25), quantity: 15, remaining_quantity: 13, lot_number: "20044")
product_lot4bis = ProductLot.create!(product_id: product4.id ,production_date: Date.new(2020,3,26) ,expiry_date: Date.new(2020,5,26), quantity: 7, remaining_quantity: 7, lot_number: "20045")

#lot avec stock faible
product_lot5 = ProductLot.create!(product_id: product5.id ,production_date: Date.new(2020,2,25) ,expiry_date: Date.new(2020,5,25), quantity: 50, remaining_quantity: 4, lot_number: "20046")
product_lot6 = ProductLot.create!(product_id: product6.id ,production_date: Date.new(2020,2,25) ,expiry_date: Date.new(2021,2,25), quantity: 50, remaining_quantity: 2, lot_number: "20047")

#lot avec date de préremption inf à 15 jrs
product_lot7 = ProductLot.create!(product_id: product7.id ,production_date: Date.new(2019,1,30) ,expiry_date: Date.new(2020,7,30), quantity: 50, remaining_quantity: 10, lot_number: "20048")
product_lot8 = ProductLot.create!(product_id: product8.id ,production_date: Date.new(2019,1,31) ,expiry_date: Date.new(2020,5,31), quantity: 50, remaining_quantity: 5, lot_number: "20049")
puts "product_lot done"

#lot pour les produits 9 à 23
product_lot9 = ProductLot.create!(product_id: product9.id ,production_date: Date.new(2020,3,1) ,expiry_date: Date.new(2020,9,1), quantity: 50, remaining_quantity: 45, lot_number: "20424")
product_lot10 = ProductLot.create!(product_id: product10.id ,production_date: Date.new(2020,3,15) ,expiry_date: Date.new(2020,9,15), quantity: 15, remaining_quantity: 10, lot_number: "20050")
product_lot11 = ProductLot.create!(product_id: product11.id ,production_date: Date.new(2019,4,30) ,expiry_date: Date.new(2020,4,30), quantity: 5, remaining_quantity: 5, lot_number: "20051")
product_lot11b = ProductLot.create!(product_id: product11.id ,production_date: Date.new(2020,4,22) ,expiry_date: Date.new(2021,4,22), quantity: 7, remaining_quantity: 7, lot_number: "20052")
product_lot12 = ProductLot.create!(product_id: product12.id ,production_date: Date.new(2020,3,1) ,expiry_date: Date.new(2020,6,1), quantity: 50, remaining_quantity: 45, lot_number: "200412")
product_lot13 = ProductLot.create!(product_id: product13.id ,production_date: Date.new(2020,3,15) ,expiry_date: Date.new(2020,9,15), quantity: 15, remaining_quantity: 10, lot_number: "20413")
product_lot14 = ProductLot.create!(product_id: product14.id ,production_date: Date.new(2020,3,20) ,expiry_date: Date.new(2020,10,20), quantity: 10, remaining_quantity: 8, lot_number: "20414")
product_lot15 = ProductLot.create!(product_id: product15.id ,production_date: Date.new(2020,3,1) ,expiry_date: Date.new(2020,10,1), quantity: 50, remaining_quantity: 45, lot_number: "20415")
product_lot16 = ProductLot.create!(product_id: product16.id ,production_date: Date.new(2020,3,15) ,expiry_date: Date.new(2020,10,15), quantity: 15, remaining_quantity: 10, lot_number: "20416")
product_lot17 = ProductLot.create!(product_id: product17.id ,production_date: Date.new(2020,3,20) ,expiry_date: Date.new(2020,5,20), quantity: 10, remaining_quantity: 8, lot_number: "200417")
product_lot18 = ProductLot.create!(product_id: product18.id ,production_date: Date.new(2020,3,20) ,expiry_date: Date.new(2020,7,20), quantity: 10, remaining_quantity: 8, lot_number: "20418")
product_lot19 = ProductLot.create!(product_id: product19.id ,production_date: Date.new(2020,4,21) ,expiry_date: Date.new(2020,5,21), quantity: 6, remaining_quantity: 6, lot_number: "20419")
product_lot20 = ProductLot.create!(product_id: product20.id ,production_date: Date.new(2020,4,21) ,expiry_date: Date.new(2020,5,21), quantity: 7, remaining_quantity: 7, lot_number: "20420")
product_lot21 = ProductLot.create!(product_id: product21.id ,production_date: Date.new(2020,4,21) ,expiry_date: Date.new(2020,5,21), quantity: 8, remaining_quantity: 8, lot_number: "20421")
product_lot22 = ProductLot.create!(product_id: product22.id ,production_date: Date.new(2020,4,20) ,expiry_date: Date.new(2020,10,20), quantity: 10, remaining_quantity: 9, lot_number: "20422")
product_lot23 = ProductLot.create!(product_id: product23.id ,production_date: Date.new(2020,4,24) ,expiry_date: Date.new(2020,10,24), quantity: 8, remaining_quantity: 6, lot_number: "20423")

# 7 - create "order_line_product_lots" pour les 4 premiers produits
order_line_product_lot1 = OrderLineProductLot.create!(order_line_id: order_line1.id ,product_lot_id: product_lot1.id ,quantity: 5)
order_line_product_lot2 = OrderLineProductLot.create!(order_line_id: order_line2.id ,product_lot_id: product_lot2.id ,quantity: 5)
order_line_product_lot3 = OrderLineProductLot.create!(order_line_id: order_line3.id ,product_lot_id: product_lot3.id ,quantity: 2)
order_line_product_lot4 = OrderLineProductLot.create!(order_line_id: order_line4.id ,product_lot_id: product_lot4.id ,quantity: 2)
puts "order_line_product_done"
puts""
puts"made with love by the cat's team"
puts""
puts"               )|._.,--....,'``.       "
puts" .b--.        /;   _.. |   _|  (`._ ,. "
puts"`=,-,-'~~~   `----(,_..'--(,_..'`-.;.'"

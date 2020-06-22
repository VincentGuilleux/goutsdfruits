require "open-uri"

OrderLineProductLot.destroy_all
ProductLot.destroy_all
OrderLine.destroy_all
Order.destroy_all
Client.destroy_all
Product.destroy_all
DeliveryPlace.destroy_all

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

# 1 - Create user & clients
user_admin = Client.create!(first_name: 'Marie', last_name: 'Gazeau', email: 'goutsdfruits@gmail.com', phone:'0608047585', address: "L'Orgerie", post_code: "79140", city: "Le Pin", segment:"particulier", role:"admin", password: 'azerty99!', amap: "Non-membre", confirmed_at: "2020-03-23")
user_admin.avatar.attach(io: File.open(Rails.root.join('db/fixtures/users/madame-gazeau.jpg')), filename: 'madame-gazeau.jpg', content_type: 'image/jpg')
user_admin.save!

client1 = Client.create!(first_name: "Vincent", last_name:"Guilleux", email:"vincent.guilleux11@gmail.com", phone:"", address:"28 rue Robert Chevrier",post_code:"35200", city:"Rennes",created_at:"2020-06-22", segment:"particulier", role:"client", password: 'azerty', amap:"Non-membre", confirmed_at: "2020-06-22")

puts "      |    /|     - user & clients done"

# 2 - Create "Delivery Places"
ferme = DeliveryPlace.create!(name: "Ferme", email: "mariegazeau@gmail.com", address: "l'Orgerie" ,post_code: "79140", city: "Le Pin", timeslot: "du lundi au samedi à partir de 10h")
gaec = DeliveryPlace.create!(name: "GAEC", address: "La Billardière" ,post_code: "79140", city: "Cerizay", timeslot: "le vendredi de 17h30 à 19h30")
ine_boune_penerie = DeliveryPlace.create!(name: "Ine Boune Penerie", email: "inebounepenerie@gmail.com", address: "rue des Prairies" ,post_code: "79320", city: "Moncoutant", timeslot: "le jeudi de 17h30 à 18h45")
bocageot = DeliveryPlace.create!(name: "Bocageot", email: "lebocageot@gmail.com", address: "rue du 11 novembre" ,post_code: "79140", city: "Cerizay", timeslot: "le jeudi de 18h30 à 19h30")
asphodele = DeliveryPlace.create!(name: "Asphodèle", email: "asphodele79@gmail.com", address: "63 rue du Péré" ,post_code: "79300", city: "Bressuire", timeslot: "le jeudi de 17h30 à 18h30")
court_circuiteurs = DeliveryPlace.create!(name: "Court Circuiteurs", email: "courts-circuiteurs@netcourrier.com", address: "les Maligrettes" ,post_code: "79100", city: "Thouars", timeslot: "à préciser")
marche_legumes_and_co = DeliveryPlace.create!(name: "Légumes and Co", email: "https://fr-fr.facebook.com/legumes.and.co/", address: "La Gorère" ,post_code: "79140", city: "Combrand", timeslot: "le jeudi de 17h à 19h30")
marche_producteurs = DeliveryPlace.create!(name: "Marché producteurs", address: "sous les Halles" ,post_code: "79140", city: "Cerizay", timeslot: "le samedi 9h à 12h30")
magasin_generique = DeliveryPlace.create!(name: "Magasin", email: "Non défini", address: "Non défini" ,post_code: "Non défini", city: "Non défini", timeslot: "Non défini")
nondefini = DeliveryPlace.create!(name: "A définir", email: "Non défini", address: "Non défini" ,post_code: "Non défini", city: "Non défini", timeslot: "Non défini")

puts "      |    /|     - delivery places done"

# 3 - create products

#les fruits au sirop

product1 = Product.new(name:"Cerises au sirop", description:"Dénoyautées, les cerises au sirop sont prêtes pour vos clafoutis ou pour égayer vos salades de fruits frais.", unit_price_cents: 600, unit_price_cents_shop: 522, unit_type:"pot", unit_measure:"cl", unit_measure_quantity:"85", unit_measure_quantity_shop:"85", product_fruit: "cerise", product_type:"fruit au sirop", product_category:"Gourmandise")
product1.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/cerises.jpg')), filename: 'cerises.jpg', content_type: 'image/jpg')
product1.save!

product2 = Product.new(name: "Prunes au sirop",description: "Dénoyautées,les prunes au sirop sont prêtes pour vos clafoutis ou pour des desserts simples et savoureux.", unit_price_cents: 600,  unit_price_cents_shop: 522, unit_type:"pot", unit_measure:"cl", unit_measure_quantity:"85", unit_measure_quantity_shop:"85", product_fruit: "prune", product_type:"fruit au sirop", product_category:"Gourmandise")
product2.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/product_nophoto.jpg')), filename: 'product_nophoto.jpg', content_type: 'image/jpg')
product2.save! # IMAGE A UPDATER

#les bonbons
product3 = Product.new(name:"Assortiment de bonbons", description:"Laissez vous tenter par ces gourmandises peu sucrées. Les cuirs de fruits sont obtenus par déshydratation pour préserver toute la saveur de fruits frais. Les bocaux contiennent un assortiment de goûts et de couleurs qui varie au fil des saisons : fraises, pêches, mûres, poires, rhubarbe...", unit_price_cents: 310, unit_price_cents_shop: 270, unit_type:"bocal", unit_measure:"ml", unit_measure_quantity:"228", unit_measure_quantity_shop:"228", product_fruit: "mix", product_type:"bonbon", product_category:"Gourmandise")
product3.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/product_nophoto.jpg')), filename: 'product_nophoto.jpg', content_type: 'image/jpg')
product3.save! # IMAGE A UPDATER

#les compotes

product4 = Product.new(name:"Compote de pommes et framboises",description:"Pour petits et grands ! Retrouvez la saveur des framboises alliée à la douceur des pommes. Toutes les compotes Goûts d'Fruits sont sans morceaux et contiennent peu de sucre ajouté.", unit_price_cents: 380, unit_price_cents_shop: 330, unit_type:"pot", unit_measure:"g", unit_measure_quantity:"450", unit_measure_quantity_shop:"450", product_fruit: "framboise", product_type:"compote", product_category:"Gourmandise")
product4.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/product_nophoto.jpg')), filename: 'product_nophoto.jpg', content_type: 'image/jpg')
product4.save! # IMAGE A UPDATER

product5 = Product.new(name:"Compote de pommes et mûres",description:"Pour petits et grands ! Retrouvez la saveur des mûres sauvages alliée à la douceur des pommes. Toutes les compotes Goûts d'Fruits sont sans morceaux et contiennent peu de sucre ajouté.", unit_price_cents: 380, unit_price_cents_shop: 330, unit_type:"pot", unit_measure:"g", unit_measure_quantity:"450", unit_measure_quantity_shop:"450", product_fruit: "mûre", product_type:"compote", product_category:"Gourmandise")
product5.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/product_nophoto.jpg')), filename: 'product_nophoto.jpg', content_type: 'image/jpg')
product5.save! # IMAGE A UPDATER

product6 = Product.new(name:"Compote de pommes et pêches",description:"Pour petits et grands ! Retrouvez la saveur des pêches d'été alliée à la douceur des pommes. Toutes les compotes Goûts d'Fruits sont sans morceaux et contiennent peu de sucre ajouté.", unit_price_cents: 380, unit_price_cents_shop: 330, unit_type:"pot", unit_measure:"g", unit_measure_quantity:"450", unit_measure_quantity_shop:"450", product_fruit: "pêche", product_type:"compote", product_category:"Gourmandise")
product6.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/product_nophoto.jpg')), filename: 'product_nophoto.jpg', content_type: 'image/jpg')
product6.save! # IMAGE A UPDATER

product7 = Product.new(name:"Compote de pommes et poires",description:"Pour petits et grands ! Retrouvez la saveur des poires alliée à la douceur des pommes. Toutes les compotes Goûts d'Fruits sont sans morceaux et contiennent peu de sucre ajouté.", unit_price_cents: 380, unit_price_cents_shop: 330, unit_type:"pot", unit_measure:"g", unit_measure_quantity:"450", unit_measure_quantity_shop:"450", product_fruit: "poire", product_type:"compote", product_category:"Gourmandise")
product7.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/product_nophoto.jpg')), filename: 'product_nophoto.jpg', content_type: 'image/jpg')
product7.save! # IMAGE A UPDATER

product8 = Product.new(name:"Compote de pommes",description:"Pour petits et grands ! Toutes les compotes Goûts d'Fruits sont sans morceaux et contiennent peu de sucre ajouté.", unit_price_cents: 380, unit_price_cents_shop: 330, unit_type:"pot", unit_measure:"g", unit_measure_quantity:"450",unit_measure_quantity_shop:"450", product_fruit: "pomme", product_type:"compote", product_category:"Gourmandise")
product8.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/compote.jpg')), filename: 'compote.jpg', content_type: 'image/jpg')
product8.save!

product9 = Product.new(name:"Compote de pommes et prunes",description:"Pour petits et grands ! Retrouvez la saveur des prunes alliée à la douceur des pommes. Toutes les compotes Goûts d'Fruits sont sans morceaux et contiennent peu de sucre ajouté.", unit_price_cents: 380, unit_price_cents_shop: 330, unit_type:"pot", unit_measure:"g", unit_measure_quantity:"450", unit_measure_quantity_shop:"450", product_fruit: "prune", product_type:"compote", product_category:"Gourmandise")
product9.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/product_nophoto.jpg')), filename: 'product_nophoto.jpg', content_type: 'image/jpg')
product9.save! # IMAGE A UPDATER

puts "cat's team     - product 1/4"

#les coulis

product10 = Product.new(name:"Coulis de cassis",description:"Dans vos yaourts, sur un gâteaux ou une glace, un coulis de cassis c'est moins sucré qu’une confiture, pour un goût plus fruité !", unit_price_cents: 590, unit_price_cents_shop: 513, unit_type:"bouteille", unit_measure:"cl", unit_measure_quantity:"25", unit_measure_quantity_shop:"25", product_fruit: "cassis", product_type:"coulis", product_category:"Gourmandise")
product10.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/coulis-cassis.jpg')), filename: 'coulis-cassis.jpg', content_type: 'image/jpg')
product10.save!

product11 = Product.new(name:"Coulis de framboises",description:"Dans vos yaourts, sur un gâteaux ou une glace, un coulis de framboises c'est moins sucré qu’une confiture, pour un goût plus fruité !", unit_price_cents: 590, unit_price_cents_shop: 513, unit_type:"bouteille", unit_measure:"cl", unit_measure_quantity:"25", unit_measure_quantity_shop:"25", product_fruit: "framboise", product_type:"coulis", product_category:"Gourmandise")
product11.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/Coulis-framboises.jpg')), filename: 'Coulis-framboises.jpg', content_type: 'image/jpg')
product11.save!

product12 = Product.new(name:"Coulis de mûres",description:"Dans vos yaourts, sur un gâteaux ou une glace, un coulis de mûres sauvages c'est moins sucré qu’une confiture, pour un goût plus fruité!", unit_price_cents: 590, unit_price_cents_shop: 513, unit_type:"bouteille", unit_measure:"cl", unit_measure_quantity:"25", unit_measure_quantity_shop:"25", product_fruit: "mûre", product_type:"coulis", product_category:"Gourmandise")
product12.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/coulis-mure.jpg')), filename: 'coulis-mure.jpg', content_type: 'image/jpg')
product12.save!

#les gelées

product13 = Product.new(name:"Gelée de cassis",description:"Sur les crêpes, les tartines, de la brioche, la gelée de cassis ensoleille vos goûters et petits déjeuners.", unit_price_cents: 320, unit_price_cents_shop: 278, unit_type:"pot", unit_measure:"g", unit_measure_quantity:"220", unit_measure_quantity_shop:"220", product_fruit: "cassis", product_type:"gelée", product_category:"Gourmandise")
product13.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/product_nophoto.jpg')), filename: 'product_nophoto.jpg', content_type: 'image/jpg')
product13.save!

product14 = Product.new(name:"Gelée de coings",description:"Allégée en sucre pour retrouver toute la saveur du coing.", unit_price_cents: 320, unit_price_cents_shop: 278, unit_type:"pot", unit_measure:"g", unit_measure_quantity:"220", unit_measure_quantity_shop:"220", product_fruit: "coing", product_type:"gelée", product_category:"Gourmandise")
product14.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/gelee-coing.jpg')), filename: 'gelee-coing', content_type: 'image/jpg')
product14.save!

product15 = Product.new(name:"Gelée de groseilles",description:"Sur les crêpes, les tartines, de la brioche, la gelée de groseille ensoleille vos goûters et petits déjeuners.", unit_price_cents: 320, unit_price_cents_shop: 278, unit_type:"pot", unit_measure:"g", unit_measure_quantity:"220", unit_measure_quantity_shop:"220", product_fruit: "groseille", product_type:"gelée", product_category:"Gourmandise")
product15.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/gelee-groseille.jpg')), filename: 'gelee-groseille.jpg', content_type: 'image/jpg')
product15.save!

product16 = Product.new(name:"Gelée de mûres",description:"Allégée en sucre pour retrouver toute la saveur des mûres sauvages.", unit_price_cents: 320, unit_price_cents_shop: 278, unit_type:"pot", unit_measure:"g", unit_measure_quantity:"220", unit_measure_quantity_shop:"220", product_fruit: "mûre", product_type:"gelée", product_category:"Gourmandise")
product16.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/geleemures.jpg')), filename: 'geleemures.jpg', content_type: 'image/jpg')
product16.save!

product17 = Product.new(name:"Gelée de pommes et fleurs de sureau",description:"Allégée en sucre pour retrouver toute la saveur de la fleur de sureau et la douceur de la pomme.", unit_price_cents: 320, unit_price_cents_shop: 278, unit_type:"pot", unit_measure:"g", unit_measure_quantity:"220", unit_measure_quantity_shop:"220", product_fruit: "sureau", product_type:"gelée", product_category:"Gourmandise")
product17.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/Gelée-sureau.jpg')), filename: 'Gelée-sureau.jpg', content_type: 'image/jpg')
product17.save!

#les sirops

product18 = Product.new(name:"Sirop de fraise",description:"Rafraîchissez vous avec ce sirop de fraises. A diluer dans 9 fois son volume d'eau, de lait ou de vin blanc !", unit_price_cents: 650, unit_price_cents_shop: 565, unit_type:"bouteille", unit_measure:"cl", unit_measure_quantity:"50",unit_measure_quantity_shop:"50", product_fruit: "fraise", product_type:"sirop", product_category:"Gourmandise")
product18.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/Sirop-fraise.jpg')), filename: 'Sirop-fraise.jpg', content_type: 'image/jpg')
product18.save!

product19 = Product.new(name:"Sirop de menthe",description:"Rafraîchissez vous avec ce sirop de menthe. A diluer dans 9 fois son volume d'eau ou de lait !", unit_price_cents: 650, unit_price_cents_shop: 565, unit_type:"bouteille", unit_measure:"cl", unit_measure_quantity:"50",unit_measure_quantity_shop:"50", product_fruit: "menthe", product_type:"sirop", product_category:"Gourmandise")
product19.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/Sirop-menthe.jpg')), filename: 'Sirop-menthe.jpg', content_type: 'image/jpg')
product19.save!

product20 = Product.new(name:"Sirop de pêche",description:"Rafraîchissez vous avec ce sirop de pêche. A diluer dans 9 fois son volume d'eau ou de lait !", unit_price_cents: 650, unit_price_cents_shop: 565,unit_type:"bouteille", unit_measure:"cl", unit_measure_quantity:"50",unit_measure_quantity_shop:"50", product_fruit: "pêche", product_type:"sirop", product_category:"Gourmandise")
product20.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/product_nophoto.jpg')), filename: 'product_nophoto.jpg', content_type: 'image/jpg')
product20.save! # IMAGE A UPDATER

product21 = Product.new(name:"Sirop de poire",description:"Rafraîchissez vous avec ce sirop de poire. A diluer dans 9 fois son volume d'eau, de lait ou de vin blanc !", unit_price_cents: 650, unit_price_cents_shop: 565, unit_type:"bouteille", unit_measure:"cl", unit_measure_quantity:"50",unit_measure_quantity_shop:"50", product_fruit: "poire", product_type:"sirop", product_category:"Gourmandise")
product21.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/Sirop-poire.jpg')), filename: 'Sirop-poire.jpg', content_type: 'image/jpg')
product21.save!

product22 = Product.new(name:"Sirop de fleurs de sureau",description:"Rafraîchissez vous avec ce sirop de fleurs de sureau. A diluer dans 9 fois son volume d'eau, de lait ou de vin blanc !", unit_price_cents: 650, unit_price_cents_shop: 565, unit_type:"bouteille", unit_measure:"cl", unit_measure_quantity:"50",unit_measure_quantity_shop:"50", product_fruit: "sureau", product_type:"sirop", product_category:"Gourmandise")
product22.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/Sirop-sureau.jpg')), filename: 'Sirop-sureau.jpg', content_type: 'image/jpg')
product22.save!

puts "       |(__)|   - product 2/4"

#les sorbets

product23 = Product.new(name:"Sorbet de fraises", description:"Préparé avec des fraises bien mûres, le sorbet doit être sorti du congélateur 10 minutes avant sa dégustation pour révéler sa texture onctueuse.", unit_price_cents: 700, unit_price_cents_shop: 609, unit_type:"pot", unit_measure:"cl", unit_measure_quantity:"50", unit_measure_quantity_shop:"50", product_fruit: "fraise", product_type:"sorbet", product_category:"Gourmandise")
product23.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/Sorbet_fraises.jpg')), filename: 'Sorbet_fraises.jpg', content_type: 'image/jpg')
product23.save!

product24 = Product.new(name: "Sorbet de menthe",description: "Préparé avec de la menthe bien mûre, le sorbet doit être sorti du congélateur 10 minutes avant sa dégustation pour révéler sa texture onctueuse", unit_price_cents: 700,  unit_price_cents_shop: 609, unit_type:"pot", unit_measure:"cl", unit_measure_quantity:"50", unit_measure_quantity_shop:"50", product_fruit: "menthe", product_type:"sorbet", product_category:"Gourmandise")
product24.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/Sorbet_menthe.jpg')), filename: 'Sorbet_menthe.jpg', content_type: 'image/jpg')
product24.save!


product25 = Product.new(name:"Sorbet de poires",description:"Préparé avec des poires bien mûres, le sorbet doit être sorti du congélateur 10 minutes avant sa dégustation pour révéler sa texture onctueuse.", unit_price_cents: 700, unit_price_cents_shop: 609, unit_type:"pot", unit_measure:"cl", unit_measure_quantity:"50", unit_measure_quantity_shop:"50", product_fruit: "poire", product_type:"sorbet", product_category:"Gourmandise")
product25.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/Sorbet_poires.jpg')), filename: 'Sorbet_poires.jpg', content_type: 'image/jpg')
product25.save!

product26 = Product.new(name:"Sorbet de fleurs de sureau",description:"Préparé avec des fleurs de sureau, le sorbet doit être sorti du congélateur 10 minutes avant sa dégustation pour révéler sa texture onctueuse.", unit_price_cents: 700, unit_price_cents_shop: 609, unit_type:"pot", unit_measure:"cl", unit_measure_quantity:"50", unit_measure_quantity_shop:"50", product_fruit: "sureau", product_type:"sorbet", product_category:"Gourmandise")
product26.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/Sorbet_sureau.jpg')), filename: 'Sorbet_sureau.jpg', content_type: 'image/jpg')
product26.save!  # IMAGE A UPDATER

#les pâtes à tartiner
product27 = Product.new(name:"Pâte à tartiner courge/chocolat",description:"Facile à tartiner, laissez vous surprendre par un goût chocolat fondu dans la douce texture du... potimarron.", unit_price_cents: 500, unit_price_cents_shop: 435, unit_type:"pot", unit_measure:"g", unit_measure_quantity:"450", unit_measure_quantity_shop:"450", product_fruit: "courge", product_type:"pâte à tartiner", product_category:"Gourmandise")
product27.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/product_nophoto.jpg')), filename: 'product_nophoto.jpg', content_type: 'image/jpg')
product27.save!

puts "       |(__)|   - product 3/4"

#les fruits frais

product29 = Product.new(name:"Cerises",description:"Des rouges vives aux bicolores, picorez un mélange de variétés de cerises bigarreau. Pour vous assurer des fruits cueillis à maturité, les variétés vendues évoluent au fil de la saison.", unit_price_cents: 350, unit_price_cents_shop: 3000, unit_type:"sachet", unit_measure:"g", unit_measure_quantity:"500", unit_measure_quantity_shop:"5000", product_fruit: "cerise", product_type:"fruit frais", product_category:"Fruit frais")
product29.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/cherry.jpg')), filename: 'cherry.jpg', content_type: 'image/jpg')
product29.save!

product30 = Product.new(name:"Framboises",description:"Rouges et blanches, les barquettes de framboises vous en feront voir de toutes les saveurs.", unit_price_cents: 200, unit_price_cents_shop: 200, unit_type:"barquette", unit_measure:"g", unit_measure_quantity:"125", unit_measure_quantity_shop:"125", product_fruit: "framboise", product_type:"fruit frais", product_category:"Fruit frais")
product30.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/FF-framboises-125g.jpg')), filename: 'FF-framboises-125g.jpg', content_type: 'image/jpg')
product30.save!

product31 = Product.new(name:"Prunes Reine Claude",description:"Reines Claudes", unit_price_cents: 200, unit_price_cents_shop: 1700, unit_type:"sachet", unit_measure:"g", unit_measure_quantity:"500", unit_measure_quantity_shop:"5000", product_fruit: "prune", product_type:"fruit frais", product_category:"Fruit frais")
product31.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/prunes.jpg')), filename: 'prunes.jpg', content_type: 'image/jpg')
product31.save!

product32 = Product.new(name:"Prunes Mirabelle",description:"Prunes Mirabelle cueillies à maturité.", unit_price_cents: 200, unit_price_cents_shop: 1700, unit_type:"sachet", unit_measure:"g", unit_measure_quantity:"500", unit_measure_quantity_shop:"5000", product_fruit: "prune", product_type:"fruit frais", product_category:"Fruit frais")
product32.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/prunes.jpg')), filename: 'prunes.jpg', content_type: 'image/jpg')
product32.save!

product33 = Product.new(name:"Pêches de vigne",description:"Les petites pêches de vigne au goûts acidulé.", unit_price_cents: 200, unit_price_cents_shop: 1700, unit_type:"sachet", unit_measure:"g", unit_measure_quantity:"500", unit_measure_quantity_shop:"5000", product_fruit: "pêche", product_type:"fruit frais", product_category:"Fruit frais")
product33.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/product_nophoto.jpg')), filename: 'product_nophoto.jpg', content_type: 'image/jpg')
product33.save!

product34 = Product.new(name:"Pêches",description:"Le verger regorge de différentes variétés de pêches qui vous seront proposées au fil de la saison en fonction de leur maturité.", unit_price_cents: 350, unit_price_cents_shop: 1700, unit_type:"sachet", unit_measure:"g", unit_measure_quantity:"1000", unit_measure_quantity_shop:"5000", product_fruit: "pêche", product_type:"fruit frais", product_category:"Fruit frais")
product34.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/product_nophoto.jpg')), filename: 'product_nophoto.jpg', content_type: 'image/jpg')
product34.save!

product35 = Product.new(name:"Pommes Clochardes",description:"La pomme clocharde originaire de Gâtine est ferme et sucrée. Elle se conserve très bien.", unit_price_cents: 250, unit_price_cents_shop: 1200, unit_type:"sachet", unit_measure:"g", unit_measure_quantity:"1000", unit_measure_quantity_shop:"5000", product_fruit: "pomme", product_type:"fruit frais", product_category:"Fruit frais")
product35.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/product_nophoto.jpg')), filename: 'product_nophoto.jpg', content_type: 'image/jpg')
product35.save!

product36 = Product.new(name:"Pommes",description:"Pommes", unit_price_cents: 250, unit_price_cents_shop: 1200, unit_type:"sachet", unit_measure:"g", unit_measure_quantity:"1000", unit_measure_quantity_shop:"5000",product_fruit: "pomme", product_type:"fruit frais", product_category:"Fruit frais")
product36.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/product_nophoto.jpg')), filename: 'product_nophoto.jpg', content_type: 'image/jpg')
product36.save!

product37 = Product.new(name:"Poires",description:"Poires", unit_price_cents: 350, unit_price_cents_shop: 1700, unit_type:"sachet", unit_measure:"g", unit_measure_quantity:"1000", unit_measure_quantity_shop:"5000",product_fruit: "poire", product_type:"fruit frais", product_category:"Fruit frais")
product37.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/product_nophoto.jpg')), filename: 'product_nophoto.jpg', content_type: 'image/jpg')
product37.save!

product38 = Product.new(name:"Coings",description:"Pour accompagner les volailles ou se lancer dans la fameuse gelée de coing.", unit_price_cents: 300, unit_price_cents_shop: 1000, unit_type:"sachet", unit_measure:"g", unit_measure_quantity:"1000", unit_measure_quantity_shop:"3000", product_fruit: "coing", product_type:"fruit frais", product_category:"Fruit frais")
product38.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/product_nophoto.jpg')), filename: 'product_nophoto.jpg', content_type: 'image/jpg')
product38.save!

product39 = Product.new(name:"Fraises",description:"Fraises cueillies à maturité pour vous régaler.", unit_price_cents: 300, unit_type:"barquette", unit_measure:"g", unit_measure_quantity:"125", unit_measure_quantity_shop:"125", product_fruit: "fraise", product_type:"fruit frais", product_category:"Fruit frais")
product39.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/product_nophoto.jpg')), filename: 'product_nophoto.jpg', content_type: 'image/jpg')
product39.save!

product40 = Product.new(name:"Rhubarbe",description:"Pour vos tartes, crumble ou en compote, la rhubarbe se marie à merveille avec les fraises ou les pommes...", unit_price_cents: 200, unit_type:"sachet", unit_measure:"g", unit_measure_quantity:"500", unit_measure_quantity_shop:"500", product_fruit: "rhubarbe", product_type:"fruit frais", product_category:"Fruit frais")
product40.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/product_nophoto.jpg')), filename: 'product_nophoto.jpg', content_type: 'image/jpg')
product40.save!

#les plants

# product22 = Product.new(name:"Plant de cassis",description:"Pour assouvir votre gourmandise et votre envie de nature, Goûts d’Fruits développe une pépinière et propose de vous accompagner dans l’aménagement de votre jardin.", unit_price_cents: 4500, unit_price_cents_shop: 4500, unit_type:"plant",product_fruit: "cassis", product_type:"végétal", product_category:"Pépinière")
# product22.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/XXX.jpg')), filename: 'XXX.jpg', content_type: 'image/jpg')
# product22.save!

#les grand plants

# product23 = Product.new(name:"Pommier",description:"Pour assouvir votre gourmandise et votre envie de nature, Goûts d’Fruits développe une pépinière et propose de vous accompagner dans l’aménagement de votre jardin.", unit_price_cents: 9000, unit_price_cents_shop: 9000, unit_type:"plant",product_fruit: "pomme", product_type:"végétal", product_category:"Pépinière")
# product23.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/XXX')), filename: 'XXX', content_type: 'image/jpg')
# product23.save!

puts "products done"



puts""
puts"made with love by the cat's team"
puts""
puts"               )|._.,--....,'``.       "
puts" .b--.        /;   _.. |   _|  (`._ ,. "
puts"`=,-,-'~~~   `----(,_..'--(,_..'`-.;.'"

require 'rails_helper'
require 'database_cleaner/active_record'
DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

RSpec.describe Product, type: :model do

  subject { # main object under test in this spec file
    product = Product.new(name:"Compote de pommes et poires",
                        description:"Pour petits et grands",
                        unit_price_cents: 380,
                        unit_price_cents_shop: 330,
                        unit_type:"pot",
                        unit_measure:"g",
                        unit_measure_quantity:"450",
                        unit_measure_quantity_shop:"450",
                        product_fruit: "poire",
                        product_type:"compote",
                        product_category:"Gourmandise"
                        )
  }

  describe "#validation tests" do
    it "is valid with valid attributes" do
      subject_with_photo = subject.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/product_nophoto.jpg')), filename: 'product_nophoto.jpg', content_type: 'image/jpg')
      expect(subject_with_photo.save).to be_truthy
      # on teste ici subject.save to be_truthy et non subject.to be_valid à cause de la photo ActiveStorage
    end

    it "is not valid without a name" do
      subject.name = nil
      expect(subject).to_not be_valid
    end
    # it "is not valid without a description"
    # it "is not valid without a type"
    # it "is not valid without a fruit"
    # it "is not valid without a category"
    # it "is not valid without a unit_price_cents"
    # it "is not valid without a unit_type"
    # it "is not valid without a unit_measure"
    # it "is not valid without a unit_measure_quantity"
    # it "is not valid without a unit_measure_quantity_shop"
  end

  # METHOD total_remaining_quantity
  describe "#total_remaining_quantity" do
    product = Product.new(name:"Compote",
                        description:"Pour petits et grands",
                        unit_price_cents: 380,
                        unit_price_cents_shop: 330,
                        unit_type:"pot",
                        unit_measure:"g",
                        unit_measure_quantity:"500",
                        unit_measure_quantity_shop:"5000",
                        product_fruit: "poire",
                        product_type:"compote",
                        product_category:"Gourmandise"
                        )
      product.photo.attach(io: File.open(Rails.root.join('db/fixtures/products/compote.jpg')), filename: 'compote.jpg')
      product.save!
      product_lot1 = ProductLot.create!(product_id: product.id, production_date: Date.new(2020,3,1), expiry_date: Date.new(2020,9,1), quantity: 50, remaining_quantity: 45, lot_number: "1")
      product_lot2 = ProductLot.create!(product_id: product.id, production_date: Date.new(2020,3,1), expiry_date: Date.new(2021,3,1), quantity: 10, remaining_quantity: 10, lot_number: "2")
      product_lot3 = ProductLot.create!(product_id: product.id, production_date: Date.new(2020,3,1), expiry_date: Date.new(2021,3,1), quantity: 30, remaining_quantity: 24, lot_number: "3")

    it "it should compute total_remaining_quantity without expired product_lots" do
      expect(product.total_remaining_quantity).to eq(34)
    end

    it "it should compute total_remaining_quantity_shop remaining without expired product_lots" do
      expect(product.total_remaining_quantity_shop).to eq(3)
    end
  end

end



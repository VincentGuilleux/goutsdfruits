require 'rails_helper'

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

  # VALIDATION TESTS
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




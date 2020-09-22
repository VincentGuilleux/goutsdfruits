require 'rails_helper'

describe "Sign-in process", type: :system do

  before do
    @client_test = create(:client)
    # test initial avec creation en dur d'une instance client (avant implementation FactoryBot)
    # client_test = Client.create!(first_name: "Vincent", last_name:"Guilleux", email:"vincent.guilleux11@gmail.com", phone:"", address:"28 rue Robert Chevrier",post_code:"35200", city:"Rennes",created_at:"2020-06-22", segment:"particulier", role:"client", password: 'azerty', amap:"Non-membre", confirmed_at: "2020-06-22")
  end


  it "signs in is valid" do
    visit '/clients/sign_in'
    fill_in 'client_email', with: @client_test.email
    fill_in 'client_password', with: @client_test.password
    click_button 'Connexion'
    expect(page).to have_content 'Connecté'
    # page.save_screenshot()
  end
end

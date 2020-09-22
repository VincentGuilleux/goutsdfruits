require 'rails_helper'

describe "sign-in process", type: :system do

  before do
    client_test = Client.create!(first_name: "Vincent", last_name:"Guilleux", email:"vincent.guilleux11@gmail.com", phone:"", address:"28 rue Robert Chevrier",post_code:"35200", city:"Rennes",created_at:"2020-06-22", segment:"particulier", role:"client", password: 'azerty', amap:"Non-membre", confirmed_at: "2020-06-22")
  end


  it "signs me in" do
    visit '/clients/sign_in'
    fill_in 'client_email', with: 'vincent.guilleux11@gmail.com'
    fill_in 'client_password', with: 'azerty'
    click_button 'Connexion'
    expect(page).to have_content 'Connecté'
    # page.save_screenshot()
  end
end

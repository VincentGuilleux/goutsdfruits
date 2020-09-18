require 'rails_helper'

describe "the signin process", type: :feature do
  # before :each do
  #   Client.make(email: 'user@example.com', password: 'password')
  # end

  it "signs me in" do
    visit '/clients/sign_in'
    save_and_open_page
    # within("#session") do
      fill_in 'client_email', with: 'vincent.guilleux11@gmail.com'
      fill_in 'client_password', with: 'azerty'

    # end
    click_button 'Connexion'
    expect(page).to have_content 'Connecté'
  end
end

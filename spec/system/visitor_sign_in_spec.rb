require 'rails_helper'

describe "sign-in process", type: :system do

  it "signs me in" do
    visit '/clients/sign_in'
    fill_in 'client_email', with: 'vincent.guilleux11@gmail.com'
    fill_in 'client_password', with: 'azerty'
    click_button 'Connexion'
    expect(page).to have_content 'Connecté'
    # page.save_screenshot()
  end
end

require 'rails_helper'

describe "sign-up process", type: :system do
  before do
    ENV['GMAIL_EMAIL']="vincent.guilleux11@gmail.com"
    ENV['GMAIL_PASSWORD']="3597bobby"
  end

  it "new sign-up" do
    before_count = Client.count
    # binding.pry
    visit '/clients/sign_up'
    fill_in 'client_first_name', with: 'Vincent'
    fill_in 'client_last_name', with: 'Guilleux'
    fill_in 'client_email', with: 'vincent.guilleux@yahoo.fr'
    fill_in 'client_address', with: '28 rue Robert Chevrier'
    fill_in 'client_post_code', with: '35200'
    fill_in 'client_city', with: 'Rennes'
    select('particulier', :from => 'client_segment')
    select('Asphodèle', :from => 'client_amap')
    fill_in 'client_password', with: 'azerty'
    fill_in 'client_password_confirmation', with: 'azerty'
    page.save_screenshot()
    click_button 'Inscription'
    expect(Client.count).not_to eq(before_count)
    # binding.pry
    # expect(page).to have_content 'Bienvenue, vous êtes connecté'
  end
end

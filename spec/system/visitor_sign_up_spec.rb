require 'rails_helper'

describe "Sign-up process", type: :system do

  before do
    @client_test = build(:client)
  end

  it "new sign-up is valid" do
    before_count = Client.count
    visit '/clients/sign_up'
    fill_in 'client_first_name', with: @client_test.first_name
    fill_in 'client_last_name', with: @client_test.last_name
    fill_in 'client_email', with: @client_test.email
    fill_in 'client_address', with: @client_test.address
    fill_in 'client_post_code', with: @client_test.post_code
    fill_in 'client_city', with: @client_test.city
    select(@client_test.segment, :from => 'client_segment')
    select(@client_test.amap, :from => 'client_amap')
    fill_in 'client_password', with: @client_test.password
    fill_in 'client_password_confirmation', with: @client_test.password
    # page.save_screenshot()
    click_button 'Inscription'
    expect(Client.count).not_to eq(before_count)
    expect(page).to have_content 'Bienvenue, vous êtes connecté'
  end
end

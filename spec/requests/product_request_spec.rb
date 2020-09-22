require 'rails_helper'

RSpec.describe "Products", type: :request do

  describe "GET #index" do
    before(:example) { get products_path }

    it "returns an http status ok" do
      expect(response).to have_http_status(:ok)
    end

    it "renders 'index' template" do
     expect(response).to render_template('index')
    end

  end

end

require 'rails_helper'

RSpec.describe Client, type: :model do

# ASSOCIATION TESTS
  describe 'associations' do
    it { should have_many(:orders) }
    it { should have_one_attached(:avatar) }
  end

  describe 'validations' do
    # For both RSpec and Shoulda, the subject is an implicit reference to the object under test, and through the use of should as demonstrated above, all of the matchers make use of subject internally when they are run. A subject is always set automatically by your test framework in any given test case; however, in certain cases it can be advantageous to override it. For instance, when testing validations in a model, it is customary to provide a valid model instead of a fresh one
    subject {
      user = Client.create!(first_name: 'Michael', last_name: 'Jordan', email: 'michaeljordan@gmail.com', phone:'0606060606', address: "TopofTheWorld", post_code: "99999", city: "Lakers", segment:"particulier", role:"client", password: 'thebestever', amap: "Non-membre", confirmed_at: "2020-10-17")
    }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:post_code) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:segment) }
    # it { should validate_inclusion_of(:segment).in_array(['particulier', 'magasin', 'marché', 'CE']) }
    it { should validate_presence_of(:amap) }
    # it { should validate_inclusion_of(:amap).in_array(['Ine Boune Penerie', 'Bocageot', 'Asphodèle' ,'Court Circuiteurs', 'Non-membre']) }

  end

end

require 'rails_helper'

RSpec.describe Tea, type: :model do
  describe 'relationships' do
    it { should belong_to :subscription }
    it { should have_many(:customers).through(:subscription) }
  end
end

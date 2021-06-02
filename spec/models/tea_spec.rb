require 'rails_helper'

RSpec.describe Tea, type: :model do
  describe 'relationships' do
    it { should belong_to :subscription }
    it { should have_many(:customers).through(:subscription) }
  end

  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :description }
    it { should validate_presence_of :brew_time }
    it { should validate_numericality_of(:brew_time).is_greater_than_or_equal_to(0) }
  end
end

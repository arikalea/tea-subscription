require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe 'relationships' do
    it { should have_many :teas }
    it { should belong_to :customer }
  end

  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :price }
    it { should validate_presence_of :status }
    it { should validate_presence_of :frequency }
    it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
    it { should define_enum_for(:status).with_values([:active, :cancelled]) }
    it { should define_enum_for(:frequency).with_values([:two_weeks, :four_weeks, :six_weeks]) }
  end
end

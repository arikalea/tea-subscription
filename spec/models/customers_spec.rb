require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it { should have_many :subscriptions }
    it { should have_many(:teas).through(:subscriptions) }
  end

  describe 'validations' do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip_code }

    it 'return an error if the email is not in the correct format' do
      customer = Customer.create(first_name: 'Sally',
                                 last_name: 'Moon',
                                 email: "Not an email",
                                 address: "123 Turing Way",
                                 city: "Denver",
                                 state: "CO",
                                 zip_code: "12345")

      expect(customer.errors[:email].to_sentence).to eq("is invalid")
    end
  end
end

require 'rails_helper'

RSpec.describe 'Get subscriptions request' do
  before :each do
    @customer = create(:customer)
    (5).times do
      create(:subscription, customer: @customer, status: :active)
    end
    (3).times do
      create(:subscription, customer: @customer, status: :cancelled)
    end
  end

  describe 'happy path' do
    it 'can return all subscriptions for a user' do
      get "/api/v1/customers/#{@customer.id}/subscriptions"

      subscriptions_json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(subscriptions_json).to be_a(Hash)
      expect(subscriptions_json).to have_key(:data)
      expect(subscriptions_json[:data]).to be_a(Array)
      expect(subscriptions_json[:data].first).to be_a(Hash)
      expect(subscriptions_json[:data].first.keys).to eq([:id, :type, :attributes])
      expect(subscriptions_json[:data].first[:id]).to be_a(String)
      expect(subscriptions_json[:data].first[:type]).to eq('subscription')
      expect(subscriptions_json[:data].first[:attributes].count).to eq(5)
      expect(subscriptions_json[:data].first[:attributes].keys).to eq([:customer_id, :title, :price, :status, :frequency])
      expect(subscriptions_json[:data].first[:attributes][:customer_id]).to eq(@customer.id)
      expect(subscriptions_json[:data].first[:attributes][:status]).to eq('active')
      expect(subscriptions_json[:data].last[:attributes][:status]).to eq('cancelled')
    end
  end

  describe 'sad path' do
    it 'unsuccessful response when incorrect customer id is provided' do
      get "/api/v1/customers/1/subscriptions"

      bad_request_json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      expect(bad_request_json).to eq({error: "Couldn't find Customer with 'id'=1"})
    end
  end
end

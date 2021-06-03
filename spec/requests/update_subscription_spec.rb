require 'rails_helper'

RSpec.describe 'Update subscription request' do
  before :each do
    @customer = create(:customer)
    @subscription = create(:subscription, customer: @customer, status: :active)
  end

  describe 'happy path' do

    it 'returns updated subscription' do
      put "/api/v1/customers/#{@customer.id}/subscriptions/#{@subscription.id}?status=cancelled"

      subscription_json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(subscription_json).to have_key(:data)
      expect(subscription_json[:data]).to be_a(Hash)
      expect(subscription_json[:data].keys).to eq([:id, :type, :attributes])
      expect(subscription_json[:data][:id]).to be_a(String)
      expect(subscription_json[:data][:type]).to eq('subscription')
      expect(subscription_json[:data][:attributes].count).to eq(5)
      expect(subscription_json[:data][:attributes].keys).to eq([:customer_id, :title, :price, :status, :frequency])
      expect(subscription_json[:data][:attributes][:customer_id]).to eq(@customer.id)
      expect(subscription_json[:data][:attributes][:title]).to eq(@subscription[:title])
      expect(subscription_json[:data][:attributes][:price]).to eq(@subscription[:price])
      expect(subscription_json[:data][:attributes][:status]).to eq('cancelled')
      expect(subscription_json[:data][:attributes][:frequency]).to eq(@subscription[:frequency].to_s)
    end
  end

  describe 'sad path' do
    # it 'unsuccessful response without require attributes' do
    #   status_params = {active: nil}
    #
    #   put "/api/v1/customers/#{@customer.id}/subscriptions/#{@subscription.id}", params: status_params.to_json
    #
    #   bad_request_json = JSON.parse(response.body, symbolize_names: true)
    #
    #   expect(response).to_not be_successful
    #   expect(response.status).to eq(400)
    #   expect(bad_request_json[:error]).to eq("Title can't be blank")
    #   expect(@subscription[:status]).to eq('active')
    # end
  end
end

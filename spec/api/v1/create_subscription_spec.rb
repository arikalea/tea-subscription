require 'rails_helper'

RSpec.describe 'Create a pet request' do
  describe 'happy path' do
    before :each do
      @customer = create(:customer)
    end

    it 'can create a subscription for a user' do
      sub_params = { customer_id: @customer.id,
                     title: 'All the Tea',
                     price: 15.99,
                     status: :active,
                     frequency: :two_weeks }
      headers = {"CONTENT_TYPE" => "application/json",
                 "ACCEPT"       => "application/json"}

      post "api/v1/customers/#{@customer.id}/subscriptions", headers: headers, params: sub_params.to_json

      new_sub = Subscription.last
      new_sub_json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(201)
      expect(response.content_type).to eq("application/json")
    end
  end
end

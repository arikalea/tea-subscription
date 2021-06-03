require 'rails_helper'

RSpec.describe 'Create a pet request' do
  before :each do
    @customer = create(:customer)
  end
  describe 'happy path' do

    it 'can create a subscription for a user' do
      sub_params = { customer_id: @customer.id,
                     title: 'All the Tea',
                     price: 15,
                     status: :active,
                     frequency: :two_weeks }
      headers = {"CONTENT_TYPE" => "application/json",
                 "ACCEPT"       => "application/json"}

      post "/api/v1/customers/#{@customer.id}/subscriptions", headers: headers, params: sub_params.to_json

      new_sub = Subscription.last
      new_sub_json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(201)
      expect(response.content_type).to eq("application/json")
      expect(new_sub_json).to be_a(Hash)
      expect(new_sub_json).to have_key(:data)
      expect(new_sub_json[:data]).to be_a(Hash)
      expect(new_sub_json[:data].keys).to eq([:id, :type, :attributes])
      expect(new_sub_json[:data][:id]).to be_a(String)
      expect(new_sub_json[:data][:type]).to eq('subscription')
      expect(new_sub_json[:data][:attributes].count).to eq(5)
      expect(new_sub_json[:data][:attributes].keys).to eq([:customer_id, :title, :price, :status, :frequency])
      expect(new_sub_json[:data][:attributes][:customer_id]).to eq(@customer.id)
      expect(new_sub_json[:data][:attributes][:title]).to eq(sub_params[:title])
      expect(new_sub_json[:data][:attributes][:price]).to eq(sub_params[:price])
      expect(new_sub_json[:data][:attributes][:status]).to eq(sub_params[:status].to_s)
      expect(new_sub_json[:data][:attributes][:frequency]).to eq(sub_params[:frequency].to_s)
    end

    it 'can create a subscription for a user with default values' do
      sub_params = { customer_id: @customer.id,
                     title: 'All the Tea',
                     price: 15 }
      headers = {"CONTENT_TYPE" => "application/json",
                 "ACCEPT"       => "application/json"}

      post "/api/v1/customers/#{@customer.id}/subscriptions", headers: headers, params: sub_params.to_json

      new_sub = Subscription.last
      new_sub_json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(201)
      expect(response.content_type).to eq("application/json")
      expect(new_sub_json).to be_a(Hash)
      expect(new_sub_json).to have_key(:data)
      expect(new_sub_json[:data]).to be_a(Hash)
      expect(new_sub_json[:data].keys).to eq([:id, :type, :attributes])
      expect(new_sub_json[:data][:id]).to be_a(String)
      expect(new_sub_json[:data][:type]).to eq('subscription')
      expect(new_sub_json[:data][:attributes].count).to eq(5)
      expect(new_sub_json[:data][:attributes].keys).to eq([:customer_id, :title, :price, :status, :frequency])
      expect(new_sub_json[:data][:attributes][:customer_id]).to eq(@customer.id)
      expect(new_sub_json[:data][:attributes][:title]).to eq(sub_params[:title])
      expect(new_sub_json[:data][:attributes][:price]).to eq(sub_params[:price])
      expect(new_sub_json[:data][:attributes][:status]).to eq('active')
      expect(new_sub_json[:data][:attributes][:frequency]).to eq('two_weeks')
    end
  end
  describe 'sad path' do
    it 'unsuccessful response without require attributes' do
      sub_params = { customer_id: @customer.id,
                     price: 15,
                     status: :active,
                     frequency: :two_weeks }
      headers = {"CONTENT_TYPE" => "application/json",
                 "ACCEPT"       => "application/json"}

      post "/api/v1/customers/#{@customer.id}/subscriptions", headers: headers, params: sub_params.to_json

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(Subscription.all.count).to eq(0)

      bad_request_json = JSON.parse(response.body, symbolize_names: true)

      expect(bad_request_json[:error]).to eq("Title can't be blank")
    end
    it 'unsuccessful response without body' do
      headers = {"CONTENT_TYPE" => "application/json",
                 "ACCEPT"       => "application/json"}

      post "/api/v1/customers/#{@customer.id}/subscriptions", headers: headers

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(Subscription.all.count).to eq(0)

      bad_request_json = JSON.parse(response.body, symbolize_names: true)

      expect(bad_request_json[:error]).to eq("Must provide request body")
    end
    it 'unsuccessful response when price is less than 0' do
      sub_params = { customer_id: @customer.id,
                     title: 'All the Tea',
                     price: -1,
                     status: :active,
                     frequency: :two_weeks }
      headers = {"CONTENT_TYPE" => "application/json",
                 "ACCEPT"       => "application/json"}

      post "/api/v1/customers/#{@customer.id}/subscriptions", headers: headers, params: sub_params.to_json

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      expect(Subscription.all.count).to eq(0)

      bad_request_json = JSON.parse(response.body, symbolize_names: true)

      expect(bad_request_json[:error]).to eq("Price must be greater than or equal to 0")
    end
  end
end

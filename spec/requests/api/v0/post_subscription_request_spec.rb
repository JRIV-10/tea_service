require "rails_helper"

RSpec.describe "ENDPOINT post /subscription", type: :request do
  describe "As a User" do

    before do
      @customer = Customer.create!({first_name: "Joe", last_name: "Ray", email: "fake@email.com", address: "123 Fake Lane Austin, TX 12345"})
      @tea = Tea.create!({title: "Early Morning", description: "Tea with alot of Caffeine", temp: 120, brew_time: 20})
      @headers = {"CONTENT_TYPE" => "application/json"}
      @body = {tea_id: @tea.id, customer_id: @customer.id, price: 55, frequency: 8, status: 1, title: @tea.title}
      @body_missing = {tea_id: @tea.id, customer_id: @customer.id, frequency: 8, status: 1, title: @tea.title}
    end

    it "creates a subscription from the request" do
      post "/api/v0/subscriptions", headers: @headers, params: JSON.generate(@body)

      expect(response).to be_successful
      expect(response.status).to eq(201)

      result = JSON.parse(response.body, symbolize_names: true)
      
      expect(result).to have_key(:data)
      expect(result[:data]).to be_a(Hash)

      data = result[:data]

      expect(data).to have_key(:id)
      expect(data[:id]).to be_a(String)
      expect(data).to have_key(:type)
      expect(data[:type]).to eq("subscription")
      expect(data).to have_key(:attributes)
      expect(data[:attributes]).to be_a(Hash)

      attributes = data[:attributes]

      expect(attributes).to have_key(:tea_id)
      expect(attributes[:tea_id]).to eq(@tea.id)
      expect(attributes).to have_key(:customer_id)
      expect(attributes[:customer_id]).to eq(@customer.id)
      expect(attributes).to have_key(:price)
      expect(attributes[:price]).to eq(55)
      expect(attributes).to have_key(:frequency)
      expect(attributes[:frequency]).to eq(8)
      expect(attributes).to have_key(:status)
      expect(attributes[:status]).to eq("active")
    end

    describe "sad path" do 
      it "errors when not all information is passed" do 
        post "/api/v0/subscriptions", headers: @headers, params: JSON.generate(@body_missing)

        expect(response).not_to be_successful
        expect(response.status).to eq(400)

        data = JSON.parse(response.body, symbolize_names: true)
        expect(data).to be_a(Hash)
        expect(data).to have_key(:errors)
        expect(data[:errors].first[:detail]).to eq("Validation failed: Price can't be blank")
      end
    end
  end 
end
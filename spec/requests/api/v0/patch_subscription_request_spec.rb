require "rails_helper"

RSpec.describe "ENDPOINT patch /subscription", type: :request do
  describe "As a User" do

    before do
      @customer = Customer.create!({first_name: "Joe", last_name: "Ray", email: "fake@email.com", address: "123 Fake Lane Austin, TX 12345"})
      @tea = Tea.create!({title: "Early Morning", description: "Tea with alot of Caffeine", temp: 120, brew_time: 20})
      @sub = Subscription.create!({tea_id: @tea.id, customer_id: @customer.id, status: 1, price: 55, frequency: 8, title: @tea.title})
      @headers = {"CONTENT_TYPE" => "application/json"}
      @body = {status: 0}
    end

    it "updates the enum status to cancel subscription" do
      patch "/api/v0/subscriptions/#{@sub.id}", headers: @headers, params: JSON.generate(@body)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      data = JSON.parse(response.body, symbolize_names: true)
      
      expect(data).to have_key(:data)
      expect(data[:data]).to be_a(Hash)

      data = data[:data]

      expect(data).to have_key(:id)
      expect(data[:id]).to be_a(String)
      expect(data).to have_key(:type)
      expect(data[:type]).to eq("subscription")
      expect(data).to have_key(:attributes)
      expect(data[:attributes]).to be_a(Hash)

      data = data[:attributes]

      expect(data).to have_key(:tea_id)
      expect(data[:tea_id]).to eq(@tea.id)
      expect(data).to have_key(:customer_id)
      expect(data[:customer_id]).to eq(@customer.id)
      expect(data).to have_key(:price)
      expect(data[:price]).to eq(55.0)
      expect(data).to have_key(:frequency)
      expect(data[:frequency]).to eq(8)
      expect(data).to have_key(:status)
      expect(data[:status]).to eq("cancelled")
    end

    describe "sad path" do 
      it "errors when there is an invalid id" do 
        patch "/api/v0/subscriptions/12345", headers: @headers, params: JSON.generate(@body)

        expect(response).not_to be_successful
        expect(response.status).to eq(404)

        data = JSON.parse(response.body, symbolize_names: true)
        expect(data).to be_a(Hash)
        expect(data).to have_key(:errors)
        expect(data[:errors].first[:detail]).to eq("Couldn't find Subscription with 'id'=12345")
      end
    end
  end 
end
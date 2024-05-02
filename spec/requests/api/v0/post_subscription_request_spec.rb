require "rails_helper"

RSpec.describe "ENDPOINT post /subscription", type: :request do
  describe "As a User" do

    before do
      @customer = Customer.create!({first_name: "Joe", last_name: "Ray", email: "fake@email.com", address: "123 Fake Lane Austin, TX 12345"})
      @tea = Tea.create!({title: "Early Morning", description: "Tea with alot of Caffeine", temp: 120, brew_time: 20})
      @headers = {"CONTENT_TYPE" => "application/json"}
      @body = {tea_id: @tea.id, customer_id: @customer.id, price: 35, frequency: 12, status: 1, title: @tea.title}
    end

    it "creates a subscription from the request" do
      post "/api/v0/subscriptions", headers: @headers, params: JSON.generate(@body)

      expect(response).to be_successful
      expect(response.status).to eq(201)
    end
  end 
end
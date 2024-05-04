require "rails_helper"

RSpec.describe "ENDPOINT get /", type: :request do
  describe "As a User" do

    before do
      @customer_1 = Customer.create!({first_name: "Test", last_name: "Last", email: "test@email.com", address: "1234 Test Dr. Los Angeles, CA 90034"})
      @tea_1 = Tea.create!({title: "Black Tea", description: "Intense", temp: 205, brew_time: 62})
      @tea_2 = Tea.create!({title: "White Tea", description: "Delicate Flavor", temp: 195, brew_time: 87})
      @tea_3 = Tea.create!({title: "Yellow Tea", description: "Nutty", temp: 163, brew_time: 120})
  
      @sub_1 = Subscription.create!({title: @tea_1.title, price: 8.2, status: 0, frequency: 2, tea_id: @tea_1.id, customer_id: @customer_1.id})
      @sub_2 = Subscription.create!({title: @tea_2.title, price: 20.0, status: 1, frequency: 4, tea_id: @tea_2.id, customer_id: @customer_1.id})
      @sub_3 = Subscription.create!({title: @tea_3.title, price: 29.99, status: 1, frequency: 6, tea_id: @tea_3.id, customer_id: @customer_1.id})
  
      @headers = {"CONTENT_TYPE" => "application/json"}
    end

    it "gets all subscriptions for a customer" do
      get "/api/v0/customers/subscriptions?customer_id=#{@customer_1.id}", headers: @headers

      expect(response).to be_successful
      expect(response.status).to eq(200)

      result = JSON.parse(response.body, symbolize_names: true)
      
      expect(result).to have_key(:data)
      expect(result[:data]).to be_a(Hash)
      
      data = result[:data]

      expect(data).to have_key(:subscriptions)
      expect(data[:subscriptions]).to be_a(Hash)

      subscriptions = data[:subscriptions]

      expect(subscriptions).to have_key(:active)
      expect(subscriptions[:active]).to be_a(Array)
      expect(subscriptions).to have_key(:cancelled)
      expect(subscriptions[:cancelled]).to be_a(Array)

      active = subscriptions[:active]

      expect(active.length).to eq(2)
      expect(active[0]).to have_key(:title)
      expect(active[0][:title]).to eq(@sub_2.title)
      expect(active[0]).to have_key(:price)
      expect(active[0][:price]).to eq(@sub_2.price)
      expect(active[0]).to have_key(:status)
      expect(active[0][:status]).to eq(@sub_2.status)
      expect(active[0]).to have_key(:frequency)
      expect(active[0][:frequency]).to eq(@sub_2.frequency)
      expect(active[0]).to have_key(:tea_id)
      expect(active[0][:tea_id]).to eq(@sub_2.tea_id)
      expect(active[0]).to have_key(:customer_id)
      expect(active[0][:customer_id]).to eq(@sub_2.customer_id)
      expect(active[1]).to have_key(:title)
      expect(active[1][:title]).to eq(@sub_3.title)
      expect(active[1]).to have_key(:price)
      expect(active[1][:price]).to eq(@sub_3.price)
      expect(active[1]).to have_key(:status)
      expect(active[1][:status]).to eq(@sub_3.status)
      expect(active[1]).to have_key(:frequency)
      expect(active[1][:frequency]).to eq(@sub_3.frequency)
      expect(active[1]).to have_key(:tea_id)
      expect(active[1][:tea_id]).to eq(@sub_3.tea_id)
      expect(active[1]).to have_key(:customer_id)
      expect(active[1][:customer_id]).to eq(@sub_3.customer_id)

      cancelled = subscriptions[:cancelled]

      expect(cancelled[0]).to have_key(:title)
      expect(cancelled[0][:title]).to eq(@sub_1.title)
      expect(cancelled[0]).to have_key(:price)
      expect(cancelled[0][:price]).to eq(@sub_1.price)
      expect(cancelled[0]).to have_key(:status)
      expect(cancelled[0][:status]).to eq(@sub_1.status)
      expect(cancelled[0]).to have_key(:frequency)
      expect(cancelled[0][:frequency]).to eq(@sub_1.frequency)
      expect(cancelled[0]).to have_key(:tea_id)
      expect(cancelled[0][:tea_id]).to eq(@sub_1.tea_id)
      expect(cancelled[0]).to have_key(:customer_id)
      expect(cancelled[0][:customer_id]).to eq(@sub_1.customer_id)
    end

    describe '#sad path' do
      it 'will return the correct error response if given an id that does not exist' do
        get "/api/v0/customers/subscriptions?customer_id=12345", headers: @headers

        expect(response).not_to be_successful
        expect(response.status).to eq(404)

        result = JSON.parse(response.body, symbolize_names: true)

        expect(result).to have_key(:errors)
        expect(result[:errors]).to be_a(Array)
        expect(result[:errors].first).to have_key(:detail)
        expect(result[:errors].first[:detail]).to eq("Couldn't find Customer with 'id'=12345")
      end
    end
  end 
end
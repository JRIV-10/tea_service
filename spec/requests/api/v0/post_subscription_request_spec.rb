require "rails_helper"

RSpec.describe "ENDPOINT post /subscription", type: :request do
  describe "As a User" do

    before do
      @customer = Customer.create!({first_name: "Joe", last_name: "Ray", email: "fake@email.com", address: "123 Fake Lane Austin, TX 12345"})
    end

    it "" do
        
    end
  end 
end
class Api::V0::CustomerSubscriptionsController < ApplicationController
  def index
    customer = Customer.find(params[:customer_id])
    render json: CustomerSubscriptionSerializer.serialize(customer.subscriptions)
  end
end
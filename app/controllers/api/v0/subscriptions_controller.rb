class Api::V0::SubscriptionsController < ApplicationController
  def create 
    # require 'pry'; binding.pry
    subscription = Subscription.create!(sub_params)
    render json: SubscriptionSerializer.new(subscription), status: 201
  end

  private 

  def sub_params
    params.require(:subscription).permit(:tea_id, :customer_id, :price, :frequency, :status, :title)
  end
end
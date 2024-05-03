class Api::V0::SubscriptionsController < ApplicationController
  def create 
    subscription = Subscription.create!(sub_params)
    render json: SubscriptionSerializer.new(subscription), status: 201
  end

  def update
    sub = Subscription.find(params[:id])
    sub.update!(sub_params)
    render json: SubscriptionSerializer.new(sub), status: 200
  end
  
  private 

  def sub_params
    params.require(:subscription).permit(:tea_id, :customer_id, :price, :frequency, :status, :title)
  end
end
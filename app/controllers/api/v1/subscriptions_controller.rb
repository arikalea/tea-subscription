class Api::V1::SubscriptionsController < ApplicationController
  def create
    subscription = Subscription.create(subscription_params)
    if subscription.save
      render json: SubscriptionSerializer.new(subscription), status: :created
    else
      render json: { error: pet.errors.full_messages.to_sentence }, status: :bad_request
    end
  end

  private

  def subscription_params
    params.permit(:customer_id, :title, :price, :status, :frequency)
  end
end

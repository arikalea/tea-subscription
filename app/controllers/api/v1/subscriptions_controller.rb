class Api::V1::SubscriptionsController < ApplicationController
  before_action :validate_params, only: [:create]

  def index
    @customer = Customer.find(params[:customer_id])
    if @customer
      render json: SubscriptionSerializer.new(@customer.subscriptions), status: :ok
    else
      render json: { error: @customer.errors.full_messages.to_sentence }, status: :bad_request
    end
  end

  def create
    subscription = Subscription.create(subscription_params)
    if subscription.save
      render json: SubscriptionSerializer.new(subscription), status: :created
    else
      render json: { error: subscription.errors.full_messages.to_sentence }, status: :bad_request
    end
  end

  def update
    subscription = Subscription.find(params[:id])
    subscription.status = update_sub_params[:status]
    if subscription.save!
      render json: SubscriptionSerializer.new(subscription), status: :ok
    else
      render json: { error: subscription.errors.full_messages.to_sentence }, status: :bad_request
    end
  end

  private

  def subscription_params
    params.permit(:customer_id, :title, :price, :status, :frequency)
  end

  def update_sub_params
    params.permit(:status, :frequency)
  end

  def validate_params
    render json: { error: 'Must provide request body' }, status: :bad_request if request.body.read.blank?
  end
end

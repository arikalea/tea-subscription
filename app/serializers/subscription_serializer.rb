class SubscriptionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :customer_id, :title, :price, :status, :frequency
end

class SubscriptionSerializer
  include JSONAPI::Serializer
  attributes :tea_id, :customer_id, :price, :frequency, :status
end

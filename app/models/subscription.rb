class Subscription < ApplicationRecord
  belongs_to :customer
  belongs_to :tea

  validates :title, presence: true
  validates :price, presence: true
  validates :status, presence: true
  validates :frequency, presence: true
  validates :tea_id, uniqueness: {scope: :customer_id}
  enum status: ["cancelled", "active"]
end

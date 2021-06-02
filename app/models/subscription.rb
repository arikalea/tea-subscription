class Subscription < ApplicationRecord
  belongs_to :customer
  has_many :teas

  validates_presence_of :title,
                        :status,
                        :frequency

  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  enum status: [:pending, :active, :cancelled]
  enum frequency: [:two_weeks, :four_weeks, :six_weeks]
end

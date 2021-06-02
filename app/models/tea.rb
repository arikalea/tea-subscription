class Tea < ApplicationRecord
  belongs_to :subscription
  has_many :customers, through: :subscription

  validates_presence_of :title,
                        :description,
                        :brew_time

  validates :brew_time, presence: true, numericality: { greater_than_or_equal_to: 0 }

end

class Tea < ApplicationRecord
  belongs_to :subscription
  has_many :customers, through: :subscription
end

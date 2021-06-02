class Customer < ApplicationRecord
  has_many :subscriptions
  has_many :teas, through: :subscriptions

  validates_presence_of :first_name,
                        :last_name,
                        :email,
                        :address,
                        :city,
                        :state,
                        :zip_code

  validates :email, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end

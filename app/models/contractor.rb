class Contractor < ApplicationRecord
  has_many :payment_requests

  validates :name, presence: true
  validates :email, presence: true
end

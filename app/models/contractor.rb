# frozen_string_literal: true

class Contractor < ApplicationRecord
  has_many :payment_requests

  validates :name, presence: true
  validates :email, presence: true
end

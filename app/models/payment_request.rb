# frozen_string_literal: true

class PaymentRequest < ApplicationRecord
  belongs_to :contractor
  before_validation :set_pending_status

  after_save :publish_to_manager_dashboard

  validates :amount, presence: true
  validates :currency, presence: true
  validates :description, presence: true

  private

  def set_pending_status
    self.status = 'pending'
  end

  private

  def publish_to_manager_dashboard
    Publisher.publish('payment_requests', attributes)
  end
end

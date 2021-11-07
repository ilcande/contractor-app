class PaymentRequest < ApplicationRecord
  belongs_to :contractor
  before_validation :set_pending_status

  validates :amount, presence: true
  validates :currency, presence: true
  validates :description, presence: true

  private

  def set_pending_status
    self.status = 'pending'
  end
end

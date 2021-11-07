# frozen_string_literal: true

class CreatePaymentRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :payment_requests do |t|
      t.decimal :amount
      t.string :currency
      t.string :description
      t.string :status
      t.references :contractor, foreign_key: true

      t.timestamps
    end
  end
end

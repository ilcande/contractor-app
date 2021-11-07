require 'rails_helper'

RSpec.describe PaymentRequest, type: :model do
  let(:amount) { 50.0 }
  let(:currency) { 'EUR' }
  let(:description) { 'payment for october' }
  let(:contractor) { Contractor.create!(id: 1, name: "Foo Bar Name", email: "foobar@example.com") }

  subject { described_class.new(amount: amount, currency: currency, description: description, contractor_id: contractor.id) }

  describe 'associations' do
    it 'belongs to' do
      relation = described_class.reflect_on_association(:contractor)
      expect(relation.macro).to eq :belongs_to
    end
  end

  describe 'validations' do
    context 'valid attributes' do
      it { expect(subject).to be_valid }
    end

    context 'invalid attributes' do
      it 'is not valid without a proper amount' do
        subject.amount = nil
        expect(subject).to_not be_valid
      end

      it 'is not valid without an currency' do
        subject.currency = nil
        expect(subject).to_not be_valid
      end

      it 'is not valid without an description' do
        subject.description = nil
        expect(subject).to_not be_valid
      end
    end
  end
end

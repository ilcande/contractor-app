require 'rails_helper'

RSpec.describe Contractor, type: :model do
  let(:name) { 'Foo Bar Name' }
  let(:email) { "foobar@example.com" }

  subject { described_class.new(name: name, email: email) }

  describe 'associations' do
    it 'has many payment requests' do
      relation = described_class.reflect_on_association(:payment_requests)
      expect(relation.macro).to eq :has_many
    end
  end

  describe 'validations' do
    context 'valid attributes' do
      it { expect(subject).to be_valid }
    end

    context 'invalid attributes' do
      it 'is not valid without a proper name' do
        subject.name = nil
        expect(subject).to_not be_valid
      end

      it 'is not valid without an email' do
        subject.email = nil
        expect(subject).to_not be_valid
      end
    end
  end
end

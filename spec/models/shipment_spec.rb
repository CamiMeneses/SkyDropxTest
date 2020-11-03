require 'rails_helper'

RSpec.describe Shipment, type: :model do
  fixtures :shipments
  let(:user) { User.create(email: 'hello@email.com', password: '123456') }
  let(:shipment) { shipments(:good_shipment) }
  let(:incomplete_shipment) { shipments(:incomplete_shipment) }

  describe 'associations' do
    it { expect(shipment.save).to be_truthy }
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:tracking_number) }
    it { should validate_presence_of(:carrier) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:description) }
  end

  describe 'create a new shipment' do
    let(:shipment_missing_tracking_number) { shipments(:missing_tracking_number) }
    let(:shipment_missing_carrier) { shipments(:missing_carrier) }
    let(:shipment_missing_status) { shipments(:missing_status) }
    let(:shipment_missing_description) { shipments(:missing_description) }

    it { expect(shipment_missing_tracking_number.save).to be_falsy }
    it { expect(shipment_missing_carrier.save).to be_falsy }
    it { expect(shipment_missing_status.save).to be_falsy }
    it { expect(shipment_missing_description.save).to be_falsy }
    it { expect(shipment.save).to be_truthy }
  end

  describe '#search_info' do
    let(:fedex_info) { incomplete_shipment.search_info }

    it "should search the shipment's information" do
      expect(fedex_info.status).not_to be_nil
      expect(fedex_info.events.first.description).not_to be_nil
    end
  end

  describe '#update_status_and_description' do
    it 'should save the shipment with its complete information' do
      incomplete_shipment.update_status_and_description

      expect(incomplete_shipment.status).not_to be_nil
      expect(incomplete_shipment.description).not_to be_nil
    end
  end
end

require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'validations' do
  end

  describe "relationships" do
    it {should belong_to :invoice}
  end

  it "can test scopes" do
    invoice1 = create(:invoice)
    good = create(:transaction, result: "success", invoice_id: invoice1.id)
    expect(Transaction.successful).to include(good)
  end

  it "tests scopes " do
    invoice1 = create(:invoice)
    bad = create(:transaction, result: "failed", invoice_id: invoice1.id)
    expect(Transaction.successful).not_to include(bad)
  end
end

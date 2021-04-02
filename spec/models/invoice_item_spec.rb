require "rails_helper"

describe InvoiceItem do
  describe "relationships" do
    it { should belong_to :invoice }
    it { should belong_to :item }
  	it { should have_many(:transactions).through(:invoice) }
  	it { should have_one(:merchant).through(:item) }
  	it { should have_one(:customer).through(:invoice) }

  end
end

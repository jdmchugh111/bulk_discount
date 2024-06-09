require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "validations" do
    it { should validate_presence_of :status }
    it { should validate_presence_of :customer_id }
  end
  describe "relationships" do
    it { should belong_to :customer }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
    it { should have_many :transactions}
  end

  before(:each) do
    @merchant1 = Merchant.create!(name: 'Hair Care')
    @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
    @item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)
    @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
    @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 2)
    @ii_11 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_8.id, quantity: 6, unit_price: 10, status: 1)
    @discount1 = Discount.create(percent_discount: 10, threshold: 4, merchant_id: @merchant1.id)
    @discount2 = Discount.create(percent_discount: 5, threshold: 6, merchant_id: @merchant1.id)
    @discount3 = Discount.create(percent_discount: 25, threshold: 9, merchant_id: @merchant1.id)
  end
  describe "instance methods" do
    it "total_revenue" do
      expect(@invoice_1.total_revenue).to eq(150)
    end

    it "total_discount" do
      expect(@invoice_1.total_discount).to eq(28.5)
    end
    
    it "discounted_revenue" do
      expect(@invoice_1.discounted_revenue).to eq(121.5)
    end
  end
end

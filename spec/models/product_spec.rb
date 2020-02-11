require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    before(:each) do
      category = Category.create(name: "Clothing")
      @product = category.products.new(
        name: "crocs",
        price: 999.99,
        quantity: 69,
      )
    end

    it 'should validate successfuly if all fields are present' do
      expect(@product).to be_valid
    end

    it 'should fail validation if name is missing' do
      @product.name = nil
      expect(@product).to_not be_valid
    end

    it 'should fail validation if price is missing' do
      @product.price_cents = nil
      expect(@product).to_not be_valid
    end

    it 'should fail validation if quantity is missing' do
    end

    it 'should fail validation is category is missing' do
    end

  end
end
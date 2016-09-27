require 'rails_helper'

RSpec.describe BomStockEntity, type: :model do

  let(:item_entity) { FactoryGirl.create(:item_entity) }
  
  before(:each) do
    @amount = 3
  end

  it "assignes correct values" do
    entity_attributes = { id: item_entity.id, item_entity: item_entity, avaliable_amount: @amount }
    bom_stock_entity = BomStockEntity.new(entity_attributes)

    expect(bom_stock_entity.item_entity).to eq(item_entity)
    expect(bom_stock_entity.avaliable_amount).to eq(@amount)
  end
end
class BomStock < ActiveModelSerializers::Model

  attr_accessor :id, :event, :bom, :bom_stock_entities, :unavailable_items
  validates_presence_of :bom, :event, :bom_stock_entities, :unavailable_items

  def bom_stock_entities
    build_stock_items(bom.item_entities, available_stock(event, bom))
  end

  def build_unavailable_items(bom_entities, available_items_map)
    bom_entities.each_with_object([]) { |el, arr| available_items_map.fetch(el.i_m__to_item__c, 0) < el.i_m__amount__c ? arr << el : arr }
  end

  def build_stock_items(bom_entities, available_items_map)
    bom_entities.each_with_object([]) { |el, arr| arr << BomStockEntity.new(build_params_for_entity(el, available_items_map[el.i_m__to_item__c])) }
  end

  def available_stock(event, bom)
    bom_items_amount_map(bom).merge(order_entities_map(event)) { |_, stock, required| stock.nil? ? 0 - required : stock - required }
  end

  def stock_items_map(bom)
    StockItem.where(item: bom.items).each_with_object({}) { |el, hash| hash[el.i_m__to_item__c] = el.i_m__amount__c }
  end

  def bom_items_amount_map(bom)
    items_map = stock_items_map(bom)
    bom.items.each { |item| items_map[item.sfid] = 0 unless items_map.has_key?(item.sfid) }
    items_map
  end
  
  def order_entities_map(event)
    orders_entities(event).each_with_object({}) { |el, hash| hash[el.i_m__to_item__c] = el.i_m__amount__c }
  end

  # THIS PART REQUIRES ADDITIONAL TESTING

  # TODO
  # REWRITE THIS PART 
  # overlap calculation should go to appropriate class
  # event and opportunity overlaps query should heppend in controller(helper)


  def orders_entities(event)
    OrderRequest.get_related_entities(get_all_reques_orders(event))
  end

  def get_all_reques_orders(event)
    order_request_from_event_overlap(event).concat(order_request_from_opportunity_overlap(event)).compact.uniq
  end

  def order_request_from_event_overlap(event)
    OrderRequest.belongs_to_overlap(event).pluck(:sfid)
  end

  def order_request_from_opportunity_overlap(event)
    Opportunity.overlapping_order_requests_sfids(event)
  end

  def build_params_for_entity(bom_entity, avaliable_item)
    { id: bom_entity.id, item_entity: bom_entity, avaliable_amount: avaliable_item }
  end

end
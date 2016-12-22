class Api::V1::ItemsController < Api::V1::BaseController

  def show
    render json: Item.find(params[:id]), serializer: Api::V1::ItemDetailsSerializer
  end

  def available
    item = Item.find(params[:id])
    event = Event.find(params[:event_id])
    stock_items = client.stock_items.for_item(item)

    from_event_overlap = OrderRequest.belongs_to_overlap(event).pluck(:sfid)
    from_opportunity_overlap = Opportunity.overlapping_order_requests_sfids(event)

    order_requests = from_event_overlap.concat(from_opportunity_overlap).compact.uniq
    
    request_entities = RequestEntity.from_inventory.reserved_entities_by_item(order_requests, item)

    available_item_entity = AvailableItemEntity.new({
       id: item.id,
       name: item.name,
       sfid: item.sfid,
       category: item.category,
       stock_items: stock_items, 
       request_entities: request_entities
    })

    render json: available_item_entity, serializer: Api::V1::AvailableItemEntitySerializer
  end

end
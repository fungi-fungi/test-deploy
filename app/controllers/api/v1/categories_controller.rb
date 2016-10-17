class Api::V1::CategoriesController < Api::V1::BaseController

  def show

    category = Category.find(params[:id])

    stock_items_in_category = StockItem.where(account: client, item: Item.where(category: category))

    render json: stock_items_in_category.all, each_serializer: Api::V1::StockItemSerializer
  end

  def stock
  end

end
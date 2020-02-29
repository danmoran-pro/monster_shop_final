class Merchant::DiscountsController < Merchant::BaseController
# class Merchant::CouponsController <Merchant::ItemsController

  # def index
  #   @items = current_user.merchant.items
  # end

  def new
    @item = Item.find(params[:item_id])
  end

  def create
  end 
end 
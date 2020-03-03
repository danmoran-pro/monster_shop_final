class Merchant::DiscountsController < Merchant::BaseController

  def new
    if params[:item_id] != nil 
      @item = Item.find(params[:item_id])
    else 
      redirect_to items_path
      flash[:error] = "Please select an item to create a bulk discount on"
    end
  end

  def index
    @discounts = Discount.all 
  end 

  def create
    merchant = Merchant.find(current_user.merchant_id)
    item = Item.find(params[:item_id])
    discount = item.discounts.new(discounts_params)
    discount.merchant_id = merchant.id
    if discount.save
      redirect_to merchant_items_path(merchant)
    else
      generate_flash(discount)
      render :new
    end
  end 

  def edit 
    @discount = Discount.find(params[:id])
  end 

  def update
    discount = Discount.find(params[:id])
    if discount.update(discounts_params)
      redirect_to merchant_discounts_path
    else
      generate_flash(discount)
      render :edit
    end
  end 

  private
    def discounts_params
      params.permit(:name, :quantity, :percentage_off)
    end
end 
class Admin::Merchants::ItemsController < ApplicationController

  def index
    @merchant = User.find(params[:id])
    @items = Item.where(user_id: params[:id])
    @unsold_items = Item.unsold_items(@items)
  end

  def new
    @item = Item.new
    @merchant = User.find(params[:id])
  end

  def create
    @merchant = User.find(params[:id])
    @item = Item.new(item_params)

    @item.update(user_id: @merchant.id)
    if @item.thumbnail == nil
      @item.update(thumbnail: "https://res.cloudinary.com/teepublic/image/private/s--NfYU3VuJ--/t_Preview/b_rgb:ffffff,c_limit,f_jpg,h_630,q_90,w_630/v1484987720/production/designs/1129239_1.jpg")
    end
    if @item.save
      @item.save
      flash[:success] = "You have succesfully added #{@item.name} to your Items."
      redirect_to admin_merchant_items_path(params[:id])
    else
      @errors = @item.errors.full_messages
      render :new
    end
  end

  def edit
    @item = Item.find(params[:item_id])
    @merchant = User.find(params[:id])
  end

  def update
    @merchant = User.find(params[:id])
    @item = Item.find(params[:item_id])
    @item.update(item_params)
    @item.update(user_id: @merchant.id)
    if @item.thumbnail == nil
      @item.update(thumbnail: "https://res.cloudinary.com/teepublic/image/private/s--NfYU3VuJ--/t_Preview/b_rgb:ffffff,c_limit,f_jpg,h_630,q_90,w_630/v1484987720/production/designs/1129239_1.jpg")
    end
    if @item.save

      @item.save
      flash[:success] = "You have succesfully updated #{@item.name} in your Items."
      redirect_to admin_merchant_items_path(params[:id])
    else
      @errors = @item.errors.full_messages
      render :edit
    end
  end

  def disable
    merchant = User.find(params[:id])
    item = Item.find(params[:item_id])
    if item.enabled?
      item.enabled = 'disabled'
      item.save
    end
    flash[:success] = "#{item.name} is now available for sale"
    redirect_to admin_merchant_items_path(merchant)
  end

  def enable
    merchant = User.find(params[:id])

    item = Item.find(params[:item_id])
    if item.disabled?
      item.enabled = 'enabled'
      item.save
    end
    flash[:error] = "#{item.name} is no longer for sale"
    redirect_to admin_merchant_items_path(merchant)
  end

  def destroy
    item_name = Item.find(params[:item_id]).name
    Item.destroy(params[:item_id])
    flash[:success] = "You have succesfully deleted #{item_name} from your items."
    redirect_to admin_merchant_items_path(params[:id])
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :price, :inventory, :quantity)
  end
end

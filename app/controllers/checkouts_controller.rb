class CheckoutsController < ApplicationController

  def create
    item = Item.find(params[:item_id])
    @cart.add_item(item.id)
    session[:cart] = @cart.contents
    flash[:notice] = "You now have #{pluralize(@cart.count_of(item.id), item.title)} in your cart.  "
    redirect_to categories_path
  end

  def show
    @items = @cart.find_items
    @item_quantities = @cart.contents
  end

  def confirmation
    @items = @cart.find_valid_items
    @item_quantities = @cart.contents
  end

  # def update
  #   if params[:change] == "increase"
  #     @cart.increase_quantity(params[:item_id])
  #     redirect_to checkout_path
  #   elsif params[:change] == "decrease"
  #     @cart.decrease_quantity(params[:item_id])
  #     redirect_to checkout_path
  #   end
  # end

  def increase
    @cart.increase_quantity(params[:item_id])
    redirect_to checkout_path
  end

  def decrease
    @cart.decrease_quantity(params[:item_id])
    redirect_to checkout_path
  end

  def remove
    item = @cart.remove_item(params[:item_id])
    redirect_to checkout_path
  end
end

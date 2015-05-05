class OrdersController < ApplicationController
  def create
    order = Order.new(order_params)
    if order.save
      @cart.contents.each_pair do |item_id, quantity|
        order.order_items.create(item_id: item_id.to_i, quantity: quantity)
      end
      order.order_items.create()
      flash[:notice] = "Order Successfully Placed"
      redirect_to current_user
    else
      flash[:error] = "Grow your beard, try again"
      redirect_to checkout_path
    end
    @cart.clear
  end

  private

  def order_params
    params.require(:order).permit(:user_id, :subtotal, :item_id)
  end
end

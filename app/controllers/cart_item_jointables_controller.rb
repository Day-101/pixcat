class CartItemJointablesController < ApplicationController

  def destroy
  	@item = CartItemJointable.find(params[:id])
  	@item.destroy
  	redirect_to user_cart_path(current_user, current_user.cart)
  end

  def create
  	puts params
  end
end

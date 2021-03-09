class CartsController < ApplicationController
  before_action :set_cart, only: %i[ show edit update destroy create_item remove create ]
  before_action :redirect_if_not_owned, only: [:show]

  # GET /carts/1 or /carts/1.json
  def show
    @cart = current_user.cart
  end

  # POST /carts or /carts.json

  def create_item
    @cart.add_product(params)
    if @cart.save
      redirect_to current_user.cart
    else
      flash[:alert] = "Can't add that to the cart"
      redirect_to item_path(params[:item_id])
    end
  end

  def remove
    cart_jt = CartItemJointable.find_by(cart: @cart, item: Item.find(params[:item_id]))

    if cart_jt
      cart_jt.destroy
      flash[:notice] = "Item successfully deleted"
      redirect_to @cart
    else
      flash[:alert] = "Error while deleting item"
      redirect_to @cart
    end

  end


  # DELETE /carts/1 or /carts/1.json
  def destroy
    @cart.destroy
    respond_to do |format|
      format.html { redirect_to carts_url, notice: "Cart was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def create
    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
      name: @cart.items[0].title,
      amount: (@cart.total * 100).to_i,
      currency: 'eur',
      quantity: 1
        },],
    mode: 'payment',
    client_reference_id: current_user.email,
    success_url: cart_success_url(@cart.id) + '?session_id={CHECKOUT_SESSION_ID}',
    cancel_url: cart_cancel_url(@cart.id)
  )
  respond_to do |format|
    format.js
  end
  end

  def success

  end

  def cancel

  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def set_cart
      @cart = Cart.find(params[:cart_id])
      rescue ActiveRecord::RecordNotFound
      session[:cart_id] = current_user.cart
    end

    def redirect_if_not_owned
      redirect_to root_path unless current_user.cart.id.to_s == params[:id]
    end

    # Only allow a list of trusted parameters through.
    def cart_params
      params.fetch(:cart, {})
    end

    def cart_item_params
      params.permit(:cart_id, :item_id)
    end
end

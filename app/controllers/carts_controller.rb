class CartsController < ApplicationController
  before_action :set_cart, only: %i[ show edit update destroy create_item remove create remove_one ]
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
      flash[:alert] = "Can't add that into the cart"
      redirect_to item_path(params[:item_id])
    end
  end

  def remove_one
    @cart.remove_one(params)
    @cart.save
    redirect_to current_user.cart
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
    items = []
    orders = []

    @cart.items.each do |item|
      items << {
      name: item.title,
      amount: (item.price * 100).to_i,
      currency: 'eur',
      quantity: CartItemJointable.find_by(cart: @cart, item: item).quantity,
      }

      orders << item.id
    end
    orders = orders.join(",")

    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: items,
    mode: 'payment',
    client_reference_id: current_user.id,
    metadata: { order_id: orders, },
    success_url: cart_success_url(@cart.id) + '?session_id={CHECKOUT_SESSION_ID}',
    cancel_url: cart_cancel_url(@cart.id)
  )

    respond_to do |format|
      format.js
    end

  end

  def success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    if @session.payment_status == "paid"
      @user = User.find(@session.client_reference_id)
      @order = Order.new(user: @user)
      
      @session.metadata.order_id.split(",").each do |id|
        OrderItemJointable.create(order: @order, item: Item.find(id.to_i))
      end
      @order.save
      @order.command_send
      @user.cart.items.destroy_all

    else
    end
  end

  def cancel
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def set_cart
      begin
        @cart = Cart.find(params[:cart_id])
      rescue ActiveRecord::RecordNotFound
        session[:cart_id] = current_user.cart.id
        @cart = current_user.cart
      end
    end

    def redirect_if_not_owned
      redirect_to cart_path(current_user.cart) unless current_user.cart.id.to_s == params[:id]
    end

    # Only allow a list of trusted parameters through.
    def cart_params
      params.fetch(:cart, {})
    end

    def cart_item_params
      params.permit(:cart_id, :item_id)
    end
end

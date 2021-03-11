class Cart < ApplicationRecord
	belongs_to :user
	has_many :cart_item_jointables, dependent: :destroy
	has_many :items, through: :cart_item_jointables

	def total
		price = 0
		self.items.each { |item| price += item.price * CartItemJointable.find_by(cart: self, item: item).quantity}
		return price
	end

	def add_product(cart_params)
		cart_item = CartItemJointable.find_by(cart: self, item: Item.find(cart_params[:item_id]))
		if cart_item.nil?
			CartItemJointable.create(cart: self, item: Item.find(cart_params[:item_id]), quantity: 1)
		else
			cart_item.quantity += 1
			cart_item.save
		end
	end

	def remove_one(cart_params)
		cart_item = CartItemJointable.find_by(cart: self, item: Item.find(cart_params[:item_id]))
		if cart_item.quantity > 1
			cart_item.quantity -= 1
			cart_item.save
		end
	end

end

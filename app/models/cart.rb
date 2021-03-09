class Cart < ApplicationRecord
	belongs_to :user
	has_many :cart_item_jointables, dependent: :destroy
	has_many :items, through: :cart_item_jointables

	def total
		price = 0
		self.items.each { |item| price += item.price }
		return price
	end

	def add_product(cart_params)
		CartItemJointable.create(cart: self, item: Item.find(cart_params[:item_id]))
	end
end

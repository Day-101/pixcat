class Cart < ApplicationRecord
	belongs_to :user
	has_many :cart_item_jointables, dependent: :destroy
	has_many :items, through: :cart_item_jointables
end

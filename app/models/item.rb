class Item < ApplicationRecord
	validates :title, length: { in: 3..50 }, presence: true
	validates :description, length: { maximum: 500}, presence: true
	validates :price, numericality: { less_than: 100 }, presence: true
	has_many :cart_item_jointable, dependent: :destroy
	has_many :order_item_jointable, dependent: :destroy
	has_one_attached :cat_picture
end

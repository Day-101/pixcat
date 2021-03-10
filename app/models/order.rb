class Order < ApplicationRecord
	belongs_to :user
	has_many :order_item_jointables, dependent: :destroy
	has_many :items, through: :order_item_jointables

	def command_send
		UserMailer.command_email(self).deliver_now
	end
end

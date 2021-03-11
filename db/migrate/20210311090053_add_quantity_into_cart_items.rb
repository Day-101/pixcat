class AddQuantityIntoCartItems < ActiveRecord::Migration[6.1]
  def change
  	add_column :cart_item_jointables, :quantity, :integer
  end
end

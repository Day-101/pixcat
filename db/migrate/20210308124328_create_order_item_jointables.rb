class CreateOrderItemJointables < ActiveRecord::Migration[6.1]
  def change
    create_table :order_item_jointables do |t|

    	t.references :order, foreign_key: true
    	t.references :item, foreign_key: true

      t.timestamps
    end
  end
end

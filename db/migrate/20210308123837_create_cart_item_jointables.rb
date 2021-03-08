class CreateCartItemJointables < ActiveRecord::Migration[6.1]
  def change
    create_table :cart_item_jointables do |t|

    	t.references :cart, foreign_key: true
    	t.references :item, foreign_key: true

      t.timestamps
    end
  end
end

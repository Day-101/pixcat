class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|

    	t.string :title
    	t.text :description
    	t.decimal :price, precision: 5, scale: 2
    	t.string :image_url

      t.timestamps
    end
  end
end

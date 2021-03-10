class RemoveImageUrlFromItems < ActiveRecord::Migration[6.1]
  def change
  	remove_column :items, :image_url
  end
end

class CreateInventories < ActiveRecord::Migration[5.0]
  def change
    create_table :inventories do |t|
      t.integer :available
      t.references :product, index: true, foreign_key: true

      t.timestamps
    end
  end
end

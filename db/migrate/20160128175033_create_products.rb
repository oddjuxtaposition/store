class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.money :price
      t.integer :position

      t.timestamps
    end
  end
end

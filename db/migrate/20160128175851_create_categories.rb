class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.string :name, index: true, unique: true

      t.timestamps
    end

    create_table :product_categorizations do |t|
      t.references :product, index: true, foreign_key: true
      t.references :category, index: true, foreign_key: true
      t.timestamps
    end
    add_index :product_categorizations, [:product_id, :category_id], unique: true
  end
end

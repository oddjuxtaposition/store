class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.money :net
      t.money :processing_fee
      t.money :subtotal
      t.money :shipping_fee
      t.money :tax
      t.money :total

      t.timestamps
    end
  end
end

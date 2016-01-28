class CreateOrderItemPriceChangeNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :order_item_price_change_notifications do |t|
      t.references :order_item, index: true, foreign_key: true
      t.money :difference
      t.datetime :acknowledged_at

      t.timestamps
    end
  end
end

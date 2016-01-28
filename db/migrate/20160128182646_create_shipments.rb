class CreateShipments < ActiveRecord::Migration[5.0]
  def change
    create_table :shipments do |t|
      t.references :order, index: true, foreign_key: true

      t.timestamps
    end
    add_reference :order_items, :shipment, index: true, foreign_key: true
  end
end

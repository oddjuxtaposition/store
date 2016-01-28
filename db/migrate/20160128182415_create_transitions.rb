class CreateTransitions < ActiveRecord::Migration[5.0]
  def change
    create_table :transitions do |t|
      t.string :to_state
      t.json :metadata
      t.integer :sort_key
      t.references :stateful, index: true, polymorphic: true

      t.timestamps
    end
  end
end

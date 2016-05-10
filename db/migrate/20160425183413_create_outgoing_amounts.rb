class CreateOutgoingAmounts < ActiveRecord::Migration
  def change
    create_table :outgoing_amounts do |t|
      t.references :product, index: true, foreign_key: true
      t.references :outgoing_movement, index: true, foreign_key: true
      t.integer :quantity

      t.timestamps null: false
    end
  end
end

class CreateIncomingAmounts < ActiveRecord::Migration
  def change
    create_table :incoming_amounts do |t|
      t.integer :quantity
      t.references :product, index: true, foreign_key: true
      t.references :incoming_movement, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

class CreateTotalQuantities < ActiveRecord::Migration
  def change
    create_table :total_quantities do |t|
      t.references :product, index: true, foreign_key: true
      t.float :quantity
      t.date :expiration_date

      t.timestamps null: false
    end
  end
end

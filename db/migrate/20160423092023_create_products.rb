class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :part_number
      t.string :description
      t.text :specification
      t.string :unit
      t.integer :alert_before

      t.timestamps null: false
    end
  end
end

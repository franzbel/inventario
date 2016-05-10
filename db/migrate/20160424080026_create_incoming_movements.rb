class CreateIncomingMovements < ActiveRecord::Migration
  def change
    create_table :incoming_movements do |t|
      t.string :movement_type
      t.string :supplier
      t.string :folio

      t.timestamps null: false
    end
  end
end

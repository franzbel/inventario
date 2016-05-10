class CreateOutgoingMovements < ActiveRecord::Migration
  def change
    create_table :outgoing_movements do |t|
      t.string :movement_type
      t.string :receiver
      t.string :folio

      t.timestamps null: false
    end
  end
end

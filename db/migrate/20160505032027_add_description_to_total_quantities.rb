class AddDescriptionToTotalQuantities < ActiveRecord::Migration
  def change
    add_column :total_quantities, :description, :string
  end
end

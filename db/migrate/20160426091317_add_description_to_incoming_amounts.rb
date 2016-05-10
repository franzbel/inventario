class AddDescriptionToIncomingAmounts < ActiveRecord::Migration
  def change
    add_column :incoming_amounts, :description, :string
  end
end

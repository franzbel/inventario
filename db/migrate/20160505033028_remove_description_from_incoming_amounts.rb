class RemoveDescriptionFromIncomingAmounts < ActiveRecord::Migration
  def change
    remove_column :incoming_amounts, :description, :string
  end
end

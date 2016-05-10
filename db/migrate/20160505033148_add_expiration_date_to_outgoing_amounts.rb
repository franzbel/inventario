class AddExpirationDateToOutgoingAmounts < ActiveRecord::Migration
  def change
    add_column :outgoing_amounts, :expiration_date, :date
  end
end

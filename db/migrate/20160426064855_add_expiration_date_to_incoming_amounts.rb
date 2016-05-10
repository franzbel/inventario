class AddExpirationDateToIncomingAmounts < ActiveRecord::Migration
  def change
    add_column :incoming_amounts, :expiration_date, :date, default: '3016-04-23'
  end
end

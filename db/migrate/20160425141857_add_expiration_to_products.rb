class AddExpirationToProducts < ActiveRecord::Migration
  def change
    add_column :products, :expiration, :boolean, default: false
  end
end

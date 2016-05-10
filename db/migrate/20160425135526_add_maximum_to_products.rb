class AddMaximumToProducts < ActiveRecord::Migration
  def change
    add_column :products, :maximum, :integer, default: -1
  end
end

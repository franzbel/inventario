class AddOptimumToProducts < ActiveRecord::Migration
  def change
    add_column :products, :optimum, :integer, default: -1
  end
end

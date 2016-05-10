class AddMimimumToProducts < ActiveRecord::Migration
  def change
    add_column :products, :minimum, :integer, default: -1
  end
end

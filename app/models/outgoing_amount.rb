class OutgoingAmount < ActiveRecord::Base
  belongs_to :product
  belongs_to :outgoing_movement

  after_create :set_total_quantity

  def get_part_number
    Product.find(self.product_id).part_number
  end

  def get_description
    Product.find(self.product_id).description
  end

  def get_unit
    Product.find(self.product_id).unit
  end

  def set_total_quantity
    TotalQuantity.subtract_quantity(self.product_id, self.expiration_date, self.quantity)
  end
end

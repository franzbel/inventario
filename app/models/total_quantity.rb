class TotalQuantity < ActiveRecord::Base
  belongs_to :product
  # Si se ingresa un producto con el mismo id y la misma fecha de caducidad->se actualiza la fila(suma)
  # En caso contrario se ingresa un nuevo producto,
  def self.add_quantity(product_id, expiration_date, quantity)
    record = TotalQuantity.where('product_id = ? AND expiration_date = ?', product_id, expiration_date)
    if record.empty?
      TotalQuantity.create(:product_id => product_id,
                           :expiration_date => expiration_date,
                           :quantity => quantity,
                           :description=>Product.where(id: product_id).first.description)
    else
      record.first.update(:quantity=> record.first.quantity + quantity)
    end
  end
  #
  def self.subtract_quantity(product_id, expiration_date, quantity)
    record = TotalQuantity.where('product_id = ? AND expiration_date = ?', product_id, expiration_date)
    record.first.update(:quantity=> record.first.quantity - quantity)
  end
  # Obtenemos una alerta en caso que la cantidad de dias de procuramiento sea mayor a la cantidad de dias
  # restantes para la expiración
  def near_expiration?
    procurement_lead_time =Product.where(:id => self.product_id).first.alert_before
    remaining_days = self.expiration_date - Date.today
    if procurement_lead_time > remaining_days.to_i
      return true
    end
    false
  end
end

class Product < ActiveRecord::Base
  has_attached_file :photo,
                    styles: {medium: '300x300>', thumb: '100x100>'},
                    default_url: '/images/:style/missing.png'
  validates_attachment_content_type :photo,
                                    content_type: /\Aimage\/.*\Z/
  has_many :incoming_amounts
  has_many :incoming_movements, :through => :incoming_amounts
  has_many :outgoing_amounts
  has_many :outgoing_movements, :through => :outgoing_amounts
  has_many :total_quantities



  # sum->Calculates the sum of values on a given column. The value is returned with the same data
  # type of the column, 0 if there's no row

  # Cantidades ingresadas de un determinado producto
  def total_incoming
    self.incoming_amounts.sum(:quantity)
  end
  # Cantidades despachadas de un determinado producto
  def total_outgoing
    self.outgoing_amounts.sum(:quantity)
  end
  # Cantidad total del producto en almacén
  def total_quantity
    self.total_incoming - self.total_outgoing
  end
  # Formatear la salida
  def get_maximum
    if self.maximum == -1
      'ND'
    else
      self.maximum
    end
  end
  def get_minimum
    if self.minimum == -1
      'ND'
    else
      self.minimum
    end
  end
  def get_optimum
    if self.optimum == -1
      'ND'
    else
      self.optimum
    end
  end
  # CC -> Con caducidad, SC-> Sin caducidad
  def get_expiration
    if self.expiration
      'CC'
    else
      'SC'
    end
  end

  # Definir alertas
  # Variables utiles:
  # Tiempo de procuramiento vs caducidad
  # Cantidad total vs maximo-optimo-mínimo
  # CRITERIOS PARA LAS ALERTAS:
  # Si esta por encima del maximo -> alerta
  # Si esta por debajo del optimo -> alerta
  # Si esta por debajo del minimo -> alerta
  # Si la cantidad de dias antes de que el producto expire es mayor al tiempo de procuramiento -> alerta

  # Estamos por encima del maximo?
  def above_maximum?
    if self.maximum < self.total_quantity
      return true
    end
    false
  end
  # Estamos por debajo del optimo, pero por encima del mínimo
  def below_optimum?
    if self.optimum > self.total_quantity && self.total_quantity > self.minimum
      return true
    end
    false
  end
  # Estamos por debajo del mínimo
  def below_minimum?
    if self.minimum > self.total_quantity
      return true
    end
    false
  end
  # Retornamos true si la cantidad de dias de procuramiento de al menos un producto de un mismo conjunto de productos (mismos productos con diferentes
  # fechas de expiración) es mayor a su fecha de expiración
  def soon_expiration?
    self.total_quantities.each do |total_quantity|
      if total_quantity.near_expiration?
        return true
      end
    end
    false
  end
  # Se cumple al menos una razón para lanzar una alerta?
  def alert?
    below_optimum? || below_minimum? || above_maximum? || soon_expiration?
  end
end

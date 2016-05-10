class IncomingMovement < ActiveRecord::Base
  has_many :incoming_amounts
  has_many :products, :through => :incoming_amounts

  before_save :set_number_folio, :set_movement_type, :set_supplier

  # Obtener el ultimo numero de folio y sumarle 1
  def self.get_number_folio
    numero_folio = IncomingMovement.all.last.folio             # 'SALIDA000023'
    solo_numero = numero_folio.scan(/\d/).join('')             # '000023'
    solo_cadena = numero_folio.scan(/[a-zA-Z]/).join('')       # 'SALIDA'
    nuevo_numero = (solo_numero.to_i + 1).to_s                 # '24'
    solo_cadena + nuevo_numero.rjust(solo_numero.length, '0')  # 'SALIDA000024'
  end
  # Obtenemos el numero de folio, el tipo de movimiento y el proveedor del primer movimiento de ingreso a almacén
  def set_number_folio
    if IncomingMovement.all.length == 0
      self.folio = 'ENTRADA000001'
    else
      self.folio = IncomingMovement.get_number_folio
    end
  end

  def set_movement_type
    if IncomingMovement.all.length == 0
      self.movement_type = 'INVENTARIO INICIAL'
    end
  end

  def set_supplier
    if IncomingMovement.all.length == 0
      self.supplier = 'ALMACÉN'
    end
  end
end

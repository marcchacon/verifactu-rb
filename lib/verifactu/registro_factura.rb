module Verifactu
  # Representa <sum:RegistroFactura>
  class RegistroFactura
    attr_reader :registros, :numero_registros

    def initialize(registro:)
      throw ArgumentError, "registro must be an instance of RegistroAlta or RegistroAnulacion" unless registro.is_a?(RegistroAlta) || registro.is_a?(RegistroAnulacion)
      @registros = []
      @numero_registros = 0

      if registro.is_a?(RegistroAlta)
        añadir_alta(registro)
      else
        añadir_anulacion(registro)
      end
      

    end

    # Añadir un registro de alta al conjunto
    # @param registro [RegistroAlta] Registro de alta a añadir
    def añadir_alta(registro)
      raise ArgumentError, "No se pueden añadir más de 1000 registros" if @numero_registros >= 1000
      raise ArgumentError, "registro must be an instance of RegistroAlta" unless registro.is_a?(RegistroAlta)

      @registros << registro
      @numero_registros += 1
    end

    # Añadir un registro de anulacion al conjunto
    # @param registro [RegistroAnulacion] Registro de anulacion a añadir
    def añadir_anulacion(registro)
      raise ArgumentError, "No se pueden añadir más de 1000 registros" if @numero_registros >= 1000
      raise ArgumentError, "registro must be an instance of RegistroAnulacion" unless registro.is_a?(RegistroAnulacion)

      @registros << registro
      @numero_registros += 1
    end

  end
end

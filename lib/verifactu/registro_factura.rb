module Verifactu
  # Representa <sum:RegistroFactura>
  class RegistroFactura
    attr_reader :registros_alta, :registros_anulacion, :numero_registros

    # Inicializa un nuevo conjunto de registros de factura
    # @param registros [Array<RegistroAlta, RegistroAnulacion>] Lista de registros de alta o anulacion
    # @raise [ArgumentError] Si alguno de los registros no es una instancia de RegistroAlta o RegistroAnulacion
    def initialize(registros: [])
      raise ArgumentError, "registros debe ser un Array" unless registros.is_a?(Array)
      raise ArgumentError, "registros no puede estar vacío" if registros.empty?
      raise ArgumentError, "registros no puede tener más de 1000 elementos" if registros.size > 1000

      # He interpretado que un envio puede tener ambos tipos de registros.
      # Se puede interpretar que un envio solo puede tener registros de alta o anulacion, pero no ambos.
      # Si se quiere restringir a un solo tipo, hay que refactorizar esto.
      invalid_registro = registros.each_with_index.find { |registro, index| !registro.is_a?(RegistroAlta) && !registro.is_a?(RegistroAnulacion) }
      if invalid_registro
        registro, index = invalid_registro
        raise ArgumentError, "El registro en la posición #{index} no es una instancia de RegistroAlta o RegistroAnulacion (#{registro.class})"
      end

      @registros_alta = []
      @registros_anulacion = []
      @numero_registros = 0

      registros.each { |registro| self.añadir_registro(registro) }
    end

    # Añadir un registro de alta o anulacion al conjunto
    def añadir_registro(registro)
      raise ArgumentError, "No se pueden añadir más de 1000 registros" if @numero_registros >= 1000
      raise ArgumentError, "registro must be an instance of RegistroAlta or RegistroAnulacion" unless registro.is_a?(RegistroAlta) || registro.is_a?(RegistroAnulacion)
      
      if registro.is_a?(RegistroAlta)
        @registros_alta << registro
      else
        @registros_anulacion << registro
      end

      @numero_registros += 1
    end

  end
end

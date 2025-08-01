module Verifactu
  #
  # Representa el envío de registros de alta o de anulación de facturas al sistema de facturación.
  # Es la clase principal para manejar el registro de facturas en Verifactu.
  #
  class RegFactuSistemaFacturacion

    attr_reader :cabecera, :registro_factura

    # Crea una instancia de RegFactuSistemaFacturacion.
    # @param [Cabecera] cabecera Cabecera del sistema de facturación.
    # @param [RegistroAlta] registro Registro de alta a agregar.
    # @raise [ArgumentError] Si cabecera no es una instancia de Cabecera.
    # @example
    #   cabecera = Verifactu::Cabecera.new(obligado_emision: obligated_emision)
    #   reg_factu = Verifactu::RegFactuSistemaFacturacion.new(cabecera: cabecera)
    def initialize(cabecera:, registro:)
      # Validaciones de cabecera
      raise ArgumentError, "cabecera must be an instance of Cabecera" unless cabecera.is_a?(RegistroFacturacion::Cabecera)
      @cabecera = cabecera
      @registro_factura = []
      if registro.is_a?(RegistroFacturacion::RegistroAlta)
        agregar_registro_alta(registro)
      else
        raise ArgumentError, "registro must be an instance of RegistroAlta"
      end
    end

    # Agrega un registro de alta al sistema de facturación.
    # @param [RegistroAlta] registro_alta Registro de alta a agregar.
    # @return [RegFactuSistemaFacturacion] Instancia actual para permitir el encadenamiento de llamadas.
    # @raise [ArgumentError] Si registro_alta no es una instancia de RegistroAlta.
    # @example
    #   reg_factu = Verifactu::RegFactuSistemaFacturacion.new(cabecera: cabecera)
    #   reg_factu.agregar_registro_alta(registro_alta: registro_alta)
    #   # ... realizar otras operaciones ...
    #   reg_factu
    def agregar_registro_alta(registro_alta)
      # Validaciones de registro_alta
      raise ArgumentError, "registro_alta is required" if registro_alta.nil?
      raise ArgumentError, "registro_alta must be an instance of RegistroAlta" unless registro_alta.is_a?(RegistroFacturacion::RegistroAlta)

      @registro_factura << registro_alta
      self
    end

  end
end

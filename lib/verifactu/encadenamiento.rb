module Verifactu
  class Encadenamiento
    attr_reader :id_emisor_factura, :num_serie_factura, :fecha_expedicion, :huella

    #
    #
    def initialize(id_emisor_factura:, num_serie_factura:, fecha_expedicion:, huella:)
      raise ArgumentError, "id_emisor_factura is required" if id_emisor_factura.nil?
      raise ArgumentError, "num_serie_factura is required" if num_serie_factura.nil?
      raise ArgumentError, "fecha_expedicion is required" if fecha_expedicion.nil?
      raise ArgumentError, "huella is required" if huella.nil?

      Helper::Validador.validar_nif(id_emisor_factura)

      raise ArgumentError, "num_serie_factura debe ser una String" if !num_serie_factura.is_a?(String)
      raise ArgumentError, "num_serie_factura no puede estar vacío" if num_serie_factura.empty?
      raise ArgumentError, "num_serie_factura debe tener maximo 60 caracteres" if num_serie_factura.length > 60

      Helper::Validador.validar_fecha_pasada(fecha_expedicion)
      raise ArgumentError, "fecha_expedicion no debe ser inferior a 28/10/2024" if fecha_expedicion < Date.new(2024, 10, 28)

      raise ArgumentError, "num_serie_factura debe contener solo caracteres ASCII imprimibles" unless num_serie_factura.ascii_only? && num_serie_factura.chars.all? { |char| char.ord.between?(32, 126) }
      
      raise ArgumentError, "huella debe ser una String" if !huella.is_a?(String)
      raise ArgumentError, "huella debe tener 64 caracteres hexadecimales" if huella.length != 64 || !huella.upcase.match?(/\A[A-F0-9]{64}\z/)
      
      @id_emisor_factura = id_emisor_factura
      @num_serie_factura = num_serie_factura
      @fecha_expedicion = fecha_expedicion
      @huella = huella.upcase
    end
  end
end

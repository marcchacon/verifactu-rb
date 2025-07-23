module Verifactu
  # Representa <sum1:PersonaFisicaJuridica>
  class PersonaFisicaJuridica
    attr_reader :nombre_razon, :nif

    def initialize(nombre_razon:, nif:)
      raise ArgumentError, "nombre_razon is required" if nombre_razon.nil? || nombre_razon.empty?
      raise ArgumentError, "nombre_razon must be a string" unless nombre_razon.is_a?(String)
      raise ArgumentError, "nombre_razon debe tener un maximo de 120 caracteres" if nombre_razon.length > 120
      # Validate NIF format
      Helper::Validador.validar_nif(nif)

      @nombre_razon = nombre_razon
      @nif = nif
    end
  end
end

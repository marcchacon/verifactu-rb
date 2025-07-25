module Verifactu
  # Representa <sum1:PersonaFisicaJuridica>
  class PersonaFisicaJuridica
    attr_reader :nombre_razon, :nif, :id_otro

    def initialize(nombre_razon:, nif: nil, id_otro: nil)
      raise ArgumentError, "nombre_razon is required" if nombre_razon.nil? || nombre_razon.empty?
      raise ArgumentError, "nombre_razon must be a string" unless nombre_razon.is_a?(String)
      raise ArgumentError, "nombre_razon debe tener un maximo de 120 caracteres" if nombre_razon.length > 120

      if nif && id_otro
        raise ArgumentError, "Solo se puede definir nif o id_otro, no ambos"
      elsif nif.nil? && id_otro.nil?
        raise ArgumentError, "Debe definir al menos nif o id_otro"
      end

      # Validate NIF format
      if nif
        Verifactu::Helper::Validador.validar_nif(nif)
      end

      # Validate IDOtro if provided
      if id_otro
        raise ArgumentError, "id_otro debe ser una instancia de IDOtro" unless id_otro.is_a?(IDOtro)
      end

      @nombre_razon = nombre_razon
      @nif = nif
      @id_otro = id_otro
    end
  end
end

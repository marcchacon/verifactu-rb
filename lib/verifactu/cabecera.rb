module Verifactu
  # Representa <sum1:Cabecera>
  class Cabecera
    attr_reader :id_version, :obligado_emision, :representante, :tipo_registro_aeat, :remisionRequerimiento, :remisionVoluntaria, :indicadorRepresentante

    def initialize(id_version:, obligado_emision:, representante: nil, tipo_registro_aeat:, remisionRequerimiento: nil, remisionVoluntaria: nil )
      raise ArgumentError, "id_version is required" if id_version.nil?
      raise ArgumentError, "id_version must be a string" unless id_version.is_a?(String)
      raise ArgumentError, "id_version debe ser una string" unless id_version.is_a?(String)
      raise ArgumentError, "id_version debe tener un maximo de 3 caracteres" if id_version.length > 3

      raise ArgumentError, "obligado_emision is required" if obligado_emision.nil?
      raise ArgumentError, "obligado_emision must be an instance of PersonaFisicaJuridica" unless obligado_emision.is_a?(PersonaFisicaJuridica)
      
      raise ArgumentError, "tipo_registro_aeat is required" if tipo_registro_aeat.nil?
      
      raise ArgumentError, "representante must be an instance of Representante or nil" unless representante.nil? || representante.is_a?(PersonaFisicaJuridica)
      raise ArgumentError, "remisionRequerimiento must be an instance of RemisionRequerimiento or nil" unless remisionRequerimiento.nil? || remisionRequerimiento.is_a?(RemisionRequerimiento)
      raise ArgumentError, "remisionVoluntaria must be an instance of RemisionVoluntaria or nil" unless remisionVoluntaria.nil? || remisionVoluntaria.is_a?(RemisionVoluntaria)


      @id_version = id_version
      @obligado_emision = obligado_emision # Instancia de PersonaFisicaJuridica
      @representante = representante # Instancia de Representante
      @tipo_registro_aeat = tipo_registro_aeat

      @remisionRequerimiento = remisionRequerimiento # Instancia de RemisionRequerimiento
      @remisionVoluntaria = remisionVoluntaria # Instancia de RemisionVoluntaria
    end
  end
end

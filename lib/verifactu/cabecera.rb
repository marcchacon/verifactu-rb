module Verifactu
  # Representa <sum1:Cabecera>
  class Cabecera
    attr_reader :id_version, :obligado_emision, :representante, :remisionRequerimiento, :remisionVoluntaria

    def initialize(obligado_emision:, representante: nil, remisionRequerimiento: nil, remisionVoluntaria: nil )
      raise ArgumentError, "obligado_emision is required" if obligado_emision.nil?
      raise ArgumentError, "obligado_emision must be an instance of PersonaFisicaJuridica" unless obligado_emision.is_a?(PersonaFisicaJuridica)
      raise ArgumentError, "obligado_emision debe tener un NIF" if obligado_emision.nif.nil? || obligado_emision.nif.empty?
      
      
      raise ArgumentError, "representante must be an instance of Representante or nil" unless representante.nil? || representante.is_a?(PersonaFisicaJuridica)
      raise ArgumentError, "representante debe tener un NIF" if representante && (representante.nif.nil? || representante.nif.empty?)
      
      raise ArgumentError, "remisionRequerimiento must be an instance of RemisionRequerimiento or nil" unless remisionRequerimiento.nil? || remisionRequerimiento.is_a?(RemisionRequerimiento)
      raise ArgumentError, "remisionVoluntaria must be an instance of RemisionVoluntaria or nil" unless remisionVoluntaria.nil? || remisionVoluntaria.is_a?(RemisionVoluntaria)

      raise ArgumentError, "ID VERSION NO ES UNA VERSION ACEPTADA POR VERIFACTU" unless Verifactu::Config::L15.include?(Verifactu::Config::ID_VERSION)
      @id_version = Verifactu::Config::ID_VERSION

      @obligado_emision = obligado_emision # Instancia de PersonaFisicaJuridica
      @representante = representante # Instancia de Representante

      @remisionRequerimiento = remisionRequerimiento # Instancia de RemisionRequerimiento
      @remisionVoluntaria = remisionVoluntaria # Instancia de RemisionVoluntaria
    end
  end
end

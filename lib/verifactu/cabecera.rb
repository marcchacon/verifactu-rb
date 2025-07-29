module Verifactu
  # Representa <sum1:Cabecera>
  class Cabecera
    attr_reader :id_version, :obligado_emision, :representante, :remision_requerimiento, :remision_voluntaria

    def initialize(obligado_emision:, representante: nil, remision_requerimiento: nil, remision_voluntaria: nil )
      raise ArgumentError, "obligado_emision is required" if obligado_emision.nil?
      raise ArgumentError, "obligado_emision must be an instance of PersonaFisicaJuridica" unless obligado_emision.is_a?(PersonaFisicaJuridica)
      raise ArgumentError, "obligado_emision debe tener un NIF" if obligado_emision.nif.nil? || obligado_emision.nif.empty?


      raise ArgumentError, "representante must be an instance of PersonaFisicaJuridica or nil" unless representante.nil? || representante.is_a?(PersonaFisicaJuridica)
      raise ArgumentError, "representante debe tener un NIF" if representante && (representante.nif.nil? || representante.nif.empty?)

      raise ArgumentError, "remision_requerimiento must be an instance of RemisionRequerimiento or nil" unless remision_requerimiento.nil? || remision_requerimiento.is_a?(RemisionRequerimiento)
      raise ArgumentError, "remision_voluntaria must be an instance of RemisionVoluntaria or nil" unless remision_voluntaria.nil? || remision_voluntaria.is_a?(RemisionVoluntaria)

      raise ArgumentError, "ID VERSION NO ES UNA VERSION ACEPTADA POR VERIFACTU" unless Verifactu::Config::L15.include?(Verifactu::Config::ID_VERSION)
      @id_version = Verifactu::Config::ID_VERSION

      @obligado_emision = obligado_emision # Instancia de PersonaFisicaJuridica
      @representante = representante # Instancia de PersonaFisicaJuridica

      @remision_requerimiento = remision_requerimiento # Instancia de RemisionRequerimiento
      @remision_voluntaria = remision_voluntaria # Instancia de RemisionVoluntaria
    end
  end
end

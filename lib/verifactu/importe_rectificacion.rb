module Verifactu
  # Representa <sum1:ImporteRectificacion>
  class ImporteRectificacion
    attr_reader :base_rectificada, :cuota_rectificada, :cuota_recargo_rectificado

    def initialize(base_rectificada:, cuota_rectificada:, cuota_recargo_rectificado: nil)
      raise ArgumentError, "base_rectificada is required" if base_rectificada.nil?
      raise ArgumentError, "cuota_rectificada is required" if cuota_rectificada.nil?

      raise ArgumentError, "base_rectificada debe ser un número" unless base_rectificada.is_a?(Numeric)
      raise ArgumentError, "base_rectificada debe tener como mucho dos decimales" if base_rectificada.to_s =~ /\.\d{3,}/
      raise ArgumentError, "base_rectificada debe tener como mucho 12 dígitos antes del decimal" if base_rectificada.to_s =~ /^\d{13,}/
      
      raise ArgumentError, "cuota_rectificada debe ser un número" unless cuota_rectificada.is_a?(Numeric)
      raise ArgumentError, "cuota_rectificada debe tener como mucho dos decimales" if cuota_rectificada.to_s =~ /\.\d{3,}/
      raise ArgumentError, "cuota_rectificada debe tener como mucho 12 dígitos antes del decimal" if cuota_rectificada.to_s =~ /^\d{13,}/
      
      raise ArgumentError, "base_rectificada debe ser un número" unless base_rectificada.is_a?(Numeric)
      raise ArgumentError, "cuota_recargo_rectificado debe tener como mucho dos decimales" if cuota_recargo_rectificado && cuota_recargo_rectificado.to_s =~ /\.\d{3,}/
      raise ArgumentError, "cuota_recargo_rectificado debe tener como mucho 12 dígitos antes del decimal" if cuota_recargo_rectificado && cuota_recargo_rectificado.to_s =~ /^\d{13,}/
      
      @base_rectificada = base_rectificada
      @cuota_rectificada = cuota_rectificada
      @cuota_recargo_rectificado = cuota_recargo_rectificado
    end
  end
end

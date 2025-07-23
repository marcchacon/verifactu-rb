module Verifactu
  # Representa <sum1:RemisionRequerimiento>
  class RemisionRequerimiento
    attr_reader :RefRequerimiento, :FinRequerimiento

    # @param [String] RefRequerimiento Referencia del requerimiento
    # @param [Any, nil] FinRequerimiento si es el ultimo envio. Cualquier valor distinto de nil indica que es el ultimo envio
    def initialize(RefRequerimiento:, FinRequerimiento:  nil)
      raise ArgumentError, 'RefRequerimiento is required' if RefRequerimiento.nil?
      @RefRequerimiento = RefRequerimiento
      if FinRequerimiento
        @FinRequerimiento = "S"
      end
    end
  end
end

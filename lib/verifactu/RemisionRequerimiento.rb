module Verifactu
  # Representa <sum1:RemisionRequerimiento>
  class RemisionRequerimiento
    attr_reader :RefRequerimiento, :FinRequerimiento

    # @param [String] RefRequerimiento Sólo cuando el motivo de la remisión sea para dar respuesta
    #                   a un requerimiento de información previo efectuado por parte de la AEAT, 
    #                   se deberá indicar aquí la referencia de dicho requerimiento, 
    #                   lo que forma parte del detalle de las circunstancias de generación del registro de facturación. 
    #                   Por lo tanto, NO deberá informarse este campo en el caso de una remisión voluntaria «VERI*FACTU».
    # @param [Any, nil] FinRequerimiento Indicador que especifica que se ha
    #                   finalizado la remisión de registros de facturación tras un requerimiento, 
    #                   especialmente útil cuando se realice un envío o remisión múltiple 
    #                   y se ha de dejar constancia de que se trata del último envío. 
    #                   Si no se informa este campo se entenderá que tiene valor “N”. 
    #                   Solo puede cumplimentarse si el campo RefRequerimiento viene informado.
    def initialize(RefRequerimiento:, FinRequerimiento:  nil)
      raise ArgumentError, 'RefRequerimiento is required' if RefRequerimiento.nil?
      raise ArgumentError, 'RefRequerimiento must be a String' unless RefRequerimiento.is_a?(String)
      raise ArgumentError, 'RefRequerimiento debe tener como maximo 18 caracteres' if RefRequerimiento.length > 18
      @RefRequerimiento = RefRequerimiento
      if FinRequerimiento
        @FinRequerimiento = "S"
      end
    end
  end
end

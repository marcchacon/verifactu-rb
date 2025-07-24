module Verifactu
  # Representa <sum1:RemisionVoluntaria>
  class RemisionVoluntaria
    attr_reader :fechaFinVeriFactu, :incidencia

    def initialize(fechaFinVeriFactu: nil, incidencia:  nil)
      Helper::Validador.validar_fecha_fin_de_ano(fechaFinVeriFactu) if fechaFinVeriFactu
      raise ArgumentError, "incidencia debe estar entre los valores #{Verifactu::Config::L4.join(', ')} o ser nil" if incidencia && !Verifactu::Config::L4.include?(incidencia)
      @fechaFinVeriFactu = fechaFinVeriFactu
      @incidencia = incidencia
    end
  end
end

module Verifactu
  # Representa <sum1:RemisionVoluntaria>
  class RemisionVoluntaria
    attr_reader :FechaFinVeriFactu, :Incidencia

    def initialize(FechaFinVeriFactu: nil, Incidencia:  nil)
      Helper::Validador.validar_fecha_fin_de_ano(FechaFinVeriFactu) if FechaFinVeriFactu
      @FechaFinVeriFactu = FechaFinVeriFactu
      @Incidencia = Incidencia
    end
  end
end

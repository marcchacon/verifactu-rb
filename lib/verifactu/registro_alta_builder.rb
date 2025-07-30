module Verifactu
  class RegistroAltaBuilder
    def initialize()
      @destinatarios = []
      @lineas = []
      @factura_rectificada = []
      @factura_substituida = []
      @subsanacion = 'N'
      @rechazo_previo = 'N'
      @descripcion = VERIFACTU::Config::DESCRIPCION_OPERACION_DEFECTO
      @macrodato = 'N'
      @cupon = 'N'
      @emitida_por_tercero_o_destinatario = 'N'
    end

    def con_id_factura(id_emisor, num_serie, fecha_expedicion)
      @id_factura = Verifactu::IDFactura.new(id_emisor: id_emisor, num_serie: num_serie, fecha_expedicion: fecha_expedicion)
      self
    end

    def con_ref_externa(ref_externa)
      @ref_externa = ref_externa
      self
    end

    def con_nombre_razon_emisor(nombre_razon)
      @nombre_razon_emisor = nombre_razon
      self
    end

    def con_subsanacion(subsanacion = 'S')
      @subsanacion = subsanacion
      self
    end

    def con_rechazo_previo(rechazo_previo = 'S')
      @rechazo_previo = rechazo_previo
      self
    end

    def con_tipo_factura(tipo_factura)
      @tipo_factura = tipo_factura
      self
    end

    def con_tipo_rectificativa(tipo_rectificativa)
      @tipo_rectificativa = tipo_rectificativa
      self
    end

    def agregar_factura_rectificada(id_emisor, num_serie, fecha_expedicion)
      @factura_rectificada << Verifactu::IDFactura.new(id_emisor: id_emisor, num_serie: num_serie, fecha_expedicion: fecha_expedicion)
      self
    end

    def agregar_factura_substituida(id_emisor, num_serie, fecha_expedicion)
      @factura_substituida << Verifactu::IDFactura.new(id_emisor: id_emisor, num_serie: num_serie, fecha_expedicion: fecha_expedicion)
      self
    end

    def con_importe_rectificacion(base_rectificada, cuota_rectificada, cuota_recargo_rectificada = nil)
      @importe_rectificacion = Verifactu::ImporteRectificacion.new(base_rectificada: base_rectificada, cuota_rectificada: cuota_rectificada, cuota_recargo_rectificada: cuota_recargo_rectificada)
      self
    end

    def con_fecha_operacion(fecha_operacion)
      @fecha_operacion = fecha_operacion
      self
    end

    def con_descripcion(descripcion)
      @descripcion = descripcion
      self
    end

    def factura_simplificada_Art7273(valor = 'S')
      @factura_simplificada_Art7273 = valor
      self
    end

    def factura_sin_identificar_destinatario_Art61d(valor = 'S')
      @factura_sin_identificar_destinatario_Art61d = valor
      self
    end

    def con_macrodato(macrodato = 'S')
      @macrodato = macrodato
      self
    end

    def emitida_por_tercero_o_destinatario(valor = 'S')
      @emitida_por_tercero_o_destinatario = valor
      self
    end

    def con_tercero_con_nif(nombre_razon, identificacion)
      @tercero = Verifactu::PersonaFisicaJuridica.create_from_nif(nombre_razon: nombre_razon, nif: identificacion)
      self
    end

    def con_tercero_con_id_otro(nombre_razon, codigo_pais, id_type, id)
      @id_otro = Verifactu::IDOtro.new(codigo_pais: codigo_pais, id_type: id_type, id: id)
      @tercero = Verifactu::PersonaFisicaJuridica.create_from_id_otro(nombre_razon: nombre_razon, id_otro: @id_otro)
      self
    end

    def agregar_destinatario_nif(nombre_razon, nif)
      @destinatarios << Verifactu::PersonaFisicaJuridica.create_from_nif(nombre_razon: nombre_razon, nif: nif)
      self
    end

    def agregar_destinatario_id_otro(nombre_razon, codigo_pais, id_type, id)
      id_otro = Verifactu::IDOtro.new(codigo_pais: codigo_pais, id_type: id_type, id: id)
      @destinatarios << Verifactu::PersonaFisicaJuridica.create_from_id_otro(nombre_razon: nombre_razon, id_otro: id_otro)
      self
    end

    def tiene_cupon(valor = 'S')
      @cupon = valor
      self
    end


  end
end

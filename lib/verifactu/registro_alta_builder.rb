module Verifactu
  class RegistroAltaBuilder
    def initialize()
      @destinatarios = []
      @lineas = []
      @factura_rectificada = []
      @factura_substituida = []
      @subsanacion = 'N'
      @rechazo_previo = 'N'
      @descripcion = Verifactu::Config::DESCRIPCION_OPERACION_DEFECTO
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

    #TODO
    def agregar_desglose_operacion(desglose)
      @desglose << desglose
      self
    end

    def con_cuota_total(cuota_total)
      @cuota_total = cuota_total
      self
    end

    def con_importe_total(importe_total)
      @importe_total = importe_total
      self
    end

    def primer_registro(valor = 'S')
      @primer_registro = valor
      self
    end

    def con_encadenamiento(id_emisor, num_serie_factura, fecha_expedicion, huella)
      @encadenamiento = Verifactu::Encadenamiento.new(id_emisor_factura: id_emisor, num_serie_factura: num_serie_factura, fecha_expedicion: fecha_expedicion, huella: huella)
      self
    end

    def con_sistema_informatico(nombre_razon, nif, nombre_sistema_informatico, id_sistema_informatico, version, numero_instalacion,
                   tipo_uso_posible_solo_verifactu, tipo_uso_posible_multi_ot, indicador_multi_ot)
      @sistema_informatico = Verifactu::SistemaInformatico.new(nombre_razon: nombre_razon, nif: nif, nombre_sistema_informatico: nombre_sistema_informatico, id_sistema_informatico: id_sistema_informatico, version: version, numero_instalacion: numero_instalacion,
                   tipo_uso_posible_solo_verifactu: tipo_uso_posible_solo_verifactu, tipo_uso_posible_multi_ot: tipo_uso_posible_multi_ot, indicador_multi_ot: indicador_multi_ot)
      self
    end

    def con_fecha_hora_huso_gen_registro(fecha_hora_huso_registro)
      @fecha_hora_huso_registro = fecha_hora_huso_registro
      self
    end

    def con_id_acuerdo_sistema_informatico(id_acuerdo_sistema_informatico)
      @id_acuerdo_sistema_informatico = id_acuerdo_sistema_informatico
      self
    end

    def con_tipo_huella(tipo_huella)
      @tipo_huella = tipo_huella
      self
    end

    def con_signature(signature)
      @signature = signature
      self
    end

    def build()
      Verifactu::RegistroAlta.new(
        id_factura: @id_factura,
        ref_externa: @ref_externa, 
        nombre_razon_emisor: @nombre_razon_emisor,
        subsanacion: @subsanacion,
        rechazo_previo: @rechazo_previo,
        tipo_factura: @tipo_factura,
        tipo_rectificativa: @tipo_rectificativa,
        facturas_rectificativas: @facturas_rectificativas,
        facturas_sustituidas: @facturas_sustituidas,
        importe_rectificacion: @importe_rectificacion,
        fecha_operacion: @fecha_operacion,
        descripcion_operacion: @descripcion_operacion,
        factura_simplificada_Art7273: @factura_simplificada_Art7273,
        factura_sin_identif_destinatario_art61d: @factura_sin_identif_destinatario_Art61d,
        macrodato: @macrodato,
        emitida_por_tercero_o_destinatario: @emitida_por_tercero_o_destinatario,
        tercero: @tercero,
        destinatarios: @destinatarios,
        cupon: @cupon, 
        desglose: @desglose,
        cuota_total: @cuota_total,
        importe_total: @importe_total, 
        sistema_informatico: @sistema_informatico,
        fecha_hora_huso_gen_registro: @fecha_hora_huso_gen_registro, 
        num_registro_acuerdo_facturacion: @num_registro_acuerdo_facturacion,
        id_acuerdo_sistema_informatico: @id_acuerdo_sistema_informatico,
        tipo_huella: @tipo_huella,
        huella: @huella,
        signature: @signature
      )

    end
  end
end

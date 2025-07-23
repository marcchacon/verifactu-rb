module Verifactu
  # Representa <sum:RegistroFacturacion>
  class RegistroFacturacion
    attr_reader :id_version,
                :id_factura,
                :ref_externa,
                :nombre_razon_emisor,
                :subsanacion,
                :rechazo_previo,
                :tipo_registro_sif,
                :tipo_factura,
                :tipo_reflectiva,
                :facturas_reflectivas,
                :facturas_sustituidas,
                :importe_rectificacion,
                :fecha_operacion,
                :descripcion_operacion,
                :factura_simplificada_Art7273,
                :factura_sin_identif_destinatario_art61d,
                :macrodato,
                :emitida_por_tercero_o_destinatario,
                :tercero,
                :destinatarios,
                :cupon,
                :desglose,
                :cuota_total,
                :importe_total,
                :encadenamiento,
                :sistema_informatico,
                :fecha_hora_huso_gen_registro,
                :num_registro_acuerdo_facturacion,
                :id_acuerdo_sistema_informatico,
                :tipo_huella,
                :huella,
                :signature

    def initialize(id_version: "1.0", 
                   id_factura:,
                   ref_externa: nil, 
                   nombre_razon_emisor:,
                   subsanacion: nil,
                   rechazo_previo: nil, 
                   tipo_registro_sif:,
                   tipo_factura:, 
                   tipo_reflectiva: nil,
                   facturas_reflectivas: nil,
                   facturas_sustituidas: nil,
                   importe_rectificacion: nil,
                   fecha_operacion: nil,
                   descripcion_operacion:,
                   factura_simplificada_Art7273: nil,
                   factura_sin_identif_destinatario_art61d: nil,
                   macrodato: nil,
                   emitida_por_tercero_o_destinatario: nil,
                   tercero: nil,
                   destinatarios: nil,
                   cupon: nil, 
                   desglose:,
                   cuota_total: nil,
                   importe_total:, 
                   encadenamiento:, 
                   sistema_informatico:,
                   fecha_hora_huso_gen_registro:, 
                   num_registro_acuerdo_facturacion: nil,
                   id_acuerdo_sistema_informatico: nil,
                   tipo_huella:,
                   huella:,
                   signature: nil,)

      raise ArgumentError, "id_factura is required" if id_factura.nil?
      raise ArgumentError, "nombre_razon_emisor is required" if nombre_razon_emisor.nil? || nombre_razon_emisor.empty?
      raise ArgumentError, "nombre_razon_emisor must be a string" unless nombre_razon_emisor.is_a?(String)
      raise ArgumentError, "nombre_razon_emisor debe tener un maximo de 120 caracteres" if nombre_razon_emisor.length > 120
      raise ArgumentError, "tipo_registro_sif is required" if tipo_registro_sif.nil?
      raise ArgumentError, "tipo_factura is required" if tipo_factura.nil?
      raise ArgumentError, "descripcion_operacion is required" if descripcion_operacion.nil? || descripcion_operacion.empty?
      raise ArgumentError, "descripcion_operacion must be a string" unless descripcion_operacion.is_a?(String)
      raise ArgumentError, "descripcion_operacion debe tener un maximo de 120 caracteres" if descripcion_operacion.length > 120
      raise ArgumentError, "desglose is required" if desglose.nil?
      raise ArgumentError, "desglose must be an instance of Desglose" unless desglose.is_a?(Desglose)
      raise ArgumentError, "importe_total is required" if importe_total.nil?
      raise ArgumentError, "importe_total must be a Numeric" unless importe_total.is_a?(Numeric)
      raise ArgumentError, "encadenamiento is required" if encadenamiento.nil?
      raise ArgumentError, "encadenamiento must be an instance of EncadenamientoRegistroAnterior" unless encadenamiento.is_a?(EncadenamientoRegistroAnterior)
      raise ArgumentError, "sistema_informatico is required" if sistema_informatico.nil?
      raise ArgumentError, "sistema_informatico must be an instance of SistemaInformatico" unless sistema_informatico.is_a?(SistemaInformatico)
      raise ArgumentError, "fecha_hora_huso_gen_registro is required" if fecha_hora_huso_gen_registro.nil?
      raise ArgumentError, "tipo_huella is required" if tipo_huella.nil?
      raise ArgumentError, "huella is required" if huella.nil?
      raise ArgumentError, "huella must be a string" unless huella.is_a?(String)
      @id_version = id_version
      @id_factura = id_factura # Instancia de IDFactura
      @nombre_razon_emisor = nombre_razon_emisor
      @tipo_registro_sif = tipo_registro_sif
      @tipo_factura = tipo_factura
      @descripcion_operacion = descripcion_operacion
      @destinatarios = destinatarios # Instancia de Destinatarios
      @desglose = desglose # Instancia de Desglose
      @importe_total = importe_total
      @encadenamiento_registro_anterior = encadenamiento_registro_anterior # Instancia de EncadenamientoRegistroAnterior
      @sistema_informatico = sistema_informatico # Instancia de SistemaInformatico
      @fecha_gen_registro = fecha_gen_registro
      @hora_gen_registro = hora_gen_registro
      @huso_horario_gen_registro = huso_horario_gen_registro
    end
  end
end

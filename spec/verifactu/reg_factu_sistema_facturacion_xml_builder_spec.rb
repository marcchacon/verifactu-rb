require 'spec_helper'


RSpec.describe Verifactu::RegFactuSistemaFacturacionXmlBuilder do
  describe '.build' do

    it 'creates a valid XML representation of RegFactuSistemaFacturacion' do

      # Crea la cabecera
      cabecera = Verifactu::Cabecera.new(
        obligado_emision: Verifactu::PersonaFisicaJuridica.create_from_nif(
          nombre_razon: 'Mi empresa SL',
          nif: 'B12345674'
        ),
        representante: Verifactu::PersonaFisicaJuridica.create_from_nif(
          nombre_razon: 'Representante SL',
          nif: 'B98765432'
        ))

      # Genera la huella para el registro de alta de una factura
      huella = Verifactu::Helper::GenerarHuellaRegistroAlta.execute(
                id_emisor_factura: 'B12345674',
                num_serie_factura: 'NC202500051',
                fecha_expedicion_factura: '22-07-2025',
                tipo_factura: 'F1',
                cuota_total: '55.54',
                importe_total: '320.00',
                huella: nil, # En blanco para el primer registro (debería registrar la huella para el siguiente)
                fecha_hora_huso_gen_registro: '2025-07-22T10:00:00+02:00'
              )

      # Crea una factura de alta con los datos necesarios
      registo_alta_factura = Verifactu::RegistroAltaBuilder.new
        .con_id_factura('B12345674', 'NC202500051', '22-07-2025')
        .con_nombre_razon_emisor('Mi empresa SL') # Razón social del emisor
        .con_tipo_factura('F1') # Factura ordinaria
        #.con_fecha_operacion('22-07-2025')
        .con_descripcion_operacion('Factura Reserva 2.731 - 22/07/2025 10:00 - 22/10/2025 10:00 - AAA-0009')
        .agregar_destinatario_nif(nombre_razon: 'Brad Stark', nif: '55555555K')
        .agregar_detalle_desglose(impuesto: '01', # IVA
                                  clave_regimen: '01', # Régimen general (IVA)
                                  calificacion_operacion: 'S1',
                                  tipo_impositivo: '21',
                                  base_imponible_o_importe_no_sujeto: '264.46',
                                  cuota_repercutida: '55.54') # Uno por cada tipo de IVA con base imponible
        .con_cuota_total('55.54')
        .con_importe_total('320.00')
        .con_encadenamiento_primer_registro # Primer registro de encadenamiento
        .con_sistema_informatico(nombre_razon: 'Mi empresa SL',
                                 nif: 'B12345674',
                                 nombre_sistema_informatico: 'Mi sistema',
                                 id_sistema_informatico: 'MB',
                                 version: '1.0.0',
                                 numero_instalacion: 'Instalación 1',
                                 tipo_uso_posible_solo_verifactu: 'S',
                                 tipo_uso_posible_multi_ot: 'S',
                                 indicador_multi_ot: 'S')
        .con_fecha_hora_huso_gen_registro('2025-07-22T10:00:00+02:00')
        .con_tipo_huella('01')
        .con_huella(huella)
        .build

        # Crea el registro de facturación
        reg_factu_sistema_facturacion = Verifactu::RegFactuSistemaFacturacion.new(
          cabecera: cabecera,
          registro: registo_alta_factura
        )

        # Genera el XML
        xml = Verifactu::RegFactuSistemaFacturacionXmlBuilder.build(reg_factu_sistema_facturacion)

    end

  end
end

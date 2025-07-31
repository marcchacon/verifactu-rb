require 'spec_helper'

RSpec.describe Verifactu::RegistroAltaBuilder do
  describe '.build_standa' do

    it 'crea una factura ordinaria' do
      # Crea una factura de alta con los datos necesarios
      factura = Verifactu::RegistroAltaBuilder.new
        .con_id_factura('B02838894', 'NC202500051', '22-07-2025')
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
        .con_sistema_informatico(nombre_razon: 'Mi empresa SL',
                                 nif: 'B02838894',
                                 nombre_sistema_informatico: 'Mi sistema',
                                 id_sistema_informatico: 'MB',
                                 version: '1.0.0',
                                 numero_instalacion: 'Instalación 1',
                                 tipo_uso_posible_solo_verifactu: 'S',
                                 tipo_uso_posible_multi_ot: 'S',
                                 indicador_multi_ot: 'S')
        .con_fecha_hora_huso_gen_registro('2025-07-22T10:00:00+02:00')
        .con_tipo_huella('01')
        .build

      expect(factura).to be_a(Verifactu::RegistroAlta)
      expect(factura.id_factura.id_emisor_factura).to eq('B02838894')
      expect(factura.id_factura.num_serie_factura).to eq('NC202500051')
      expect(factura.id_factura.fecha_expedicion_factura).to eq('22-07-2025')
      expect(factura.nombre_razon_emisor).to eq('Mi empresa SL')
      expect(factura.tipo_factura).to eq('F1')
      #expect(factura.fecha_operacion).to eq('22-07-2025')
      expect(factura.descripcion_operacion).to eq('Factura Reserva 2.731 - 22/07/2025 10:00 - 22/10/2025 10:00 - AAA-0009')
      expect(factura.destinatarios.first.nombre_razon).to eq('Brad Stark')
      expect(factura.destinatarios.first.nif).to eq('55555555K')
      expect(factura.desglose.first.clave_regimen).to eq('01')
      expect(factura.desglose.first.calificacion_operacion).to eq('S1')
      expect(factura.desglose.first.tipo_impositivo).to eq('21')
      expect(factura.desglose.first.base_imponible_o_importe_no_sujeto).to eq('264.46')
      expect(factura.desglose.first.cuota_repercutida).to eq('55.54')
      expect(factura.cuota_total).to eq('55.54')
    end

  end
=begin
  describe '.create_from_id_otro' do

    it 'creates an instance with valid IDOtro' do
      id_otro = Verifactu::IDOtro.new(codigo_pais: 'FR', id_type: '02', id: '123456789')
      persona = Verifactu::PersonaFisicaJuridica.create_from_id_otro(nombre_razon: 'Test Name', id_otro: id_otro)
      expect(persona).to be_a(Verifactu::PersonaFisicaJuridica)
      expect(persona.nombre_razon).to eq('Test Name')
      expect(persona.id_otro).to eq(id_otro)
    end

  end
=end
end

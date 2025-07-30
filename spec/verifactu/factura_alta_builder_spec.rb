require 'spec_helper'

RSpec.describe Verifactu::RegistroAltaBuilder do
  describe '.build_standa' do

    it 'creates an instance with valid params' do
      desglose = Verifactu::DetalleDesglose.new(
            clave_regimen: '01',
            calificacion_operacion: 'S1',
            tipo_impositivo: '21',
            base_imponible_o_importe_no_sujeto: '264.46',
            cuota_repercutida: '55.54'
      )
      factura = Verifactu::RegistroAltaBuilder.new
        .con_id_factura('B02838894', 'NC-202500051', '22-07-2025')
        .con_nombre_razon_emisor('Karyasala SL')
        .con_tipo_factura('F1')
        .con_fecha_operacion('22-07-2025')
        .con_descripcion('Factura Reserva 2.731 - 22/07/2025 10:00 - 22/10/2025 10:00 - AAA-0009')
        .agregar_destinatario('Stark, Brad', '55555555K')
        .agregar_desglose_operacion(desglose)
        .con_cuota_total(55.54)
        .con_importe_total(320.00)
        .build

      expect(factura).to be_a(Verifactu::RegistroAlta)
      expect(factura.id_factura.id_emisor).to eq('B02838894')
      expect(factura.id_factura.num_serie).to eq('NC-202500051')
      expect(factura.id_factura.fecha_expedicion).to eq('22-07-2025')
      expect(factura.nombre_razon_emisor).to eq('Karyasala SL')
      expect(factura.tipo_factura).to eq('F1')
      expect(factura.fecha_operacion).to eq('22-07-2025')
      expect(factura.descripcion).to eq('Factura Reserva 2.731 - 22/07/2025 10:00 - 22/10/2025 10:00 - AAA-0009')
      expect(factura.destinatarios.first.nombre_razon).to eq('Stark, Brad')
      expect(factura.destinatarios.first.nif).to eq('55555555K')
      expect(factura.desglose.first.clave_regimen).to eq('01')
      expect(factura.desglose.first.calificacion_operacion).to eq('S1')
      expect(factura.desglose.first.tipo_impositivo).to eq(21.00)
      expect(factura.desglose.first.base_imponible_o_importe_no_sujeto).to eq(264.46)
      expect(factura.desglose.first.cuota_repercutida).to eq(55.54)
      expect(factura.cuota_total).to eq(55.54)
    end

  end
  describe '.create_from_id_otro' do

    it 'creates an instance with valid IDOtro' do
      id_otro = Verifactu::IDOtro.new(codigo_pais: 'FR', id_type: '02', id: '123456789')
      persona = Verifactu::PersonaFisicaJuridica.create_from_id_otro(nombre_razon: 'Test Name', id_otro: id_otro)
      expect(persona).to be_a(Verifactu::PersonaFisicaJuridica)
      expect(persona.nombre_razon).to eq('Test Name')
      expect(persona.id_otro).to eq(id_otro)
    end

  end
end

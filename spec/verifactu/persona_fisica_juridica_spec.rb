require 'spec_helper'

RSpec.describe Verifactu::PersonaFisicaJuridica do
  describe '.create_from_nif' do

    it 'creates an instance with valid NIF' do
      persona = Verifactu::PersonaFisicaJuridica.create_from_nif(nombre_razon: 'Test Name', nif: '12345678Z')
      expect(persona).to be_a(Verifactu::PersonaFisicaJuridica)
      expect(persona.nombre_razon).to eq('Test Name')
      expect(persona.nif).to eq('12345678Z')
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

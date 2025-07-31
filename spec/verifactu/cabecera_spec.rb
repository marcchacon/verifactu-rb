require 'spec_helper'

RSpec.describe Verifactu::Cabecera do

  describe '#initialize' do

    cabecera = Verifactu::Cabecera.new(
      obligado_emision: Verifactu::PersonaFisicaJuridica.create_from_nif(
        nombre_razon: 'Mi empresa SL',
        nif: 'B12345674'
      ),
      representante: Verifactu::PersonaFisicaJuridica.create_from_nif(
        nombre_razon: 'Representante SL',
        nif: 'B98765432'
      ))

  end

end

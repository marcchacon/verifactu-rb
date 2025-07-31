require 'spec_helper'


RSpec.describe Verifactu::RegFactuSistemaFacturacionXmlBuilder do
  describe '.build' do

    it 'creates a valid XML representation of RegFactuSistemaFacturacion' do

      # Crea la cabecera
      cabecera = cabecera_con_representante

      # Genera la huella para el registro de alta de una factura
      huella = huella_inicial

      # Crea una factura de alta con los datos necesarios
      registo_alta_factura = registro_alta_factura_valido(huella)

      # Crea el registro de facturación
      reg_factu_sistema_facturacion = Verifactu::RegFactuSistemaFacturacion.new(
        cabecera: cabecera,
        registro: registo_alta_factura
      )

      # Genera el XML
      xml = Verifactu::RegFactuSistemaFacturacionXmlBuilder.build(reg_factu_sistema_facturacion)

      #p "xml:: #{xml.root.to_xml}"

    end

  end
end

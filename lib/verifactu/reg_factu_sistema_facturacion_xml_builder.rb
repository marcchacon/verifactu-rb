require 'nokogiri'
module Verifactu
  class RegFactuSistemaFacturacionXmlBuilder
    #
    # It creates an XML representation of the RegFactuSistemaFacturacion.
    #
    def self.build(reg_factu_sistema_facturacion)

      # Create the XML document
      xml_document = Nokogiri::XML('<sum:RegFactuSistemaFacturacion/>')
      xml_document.encoding = 'UTF-8'
      #xml_document.root.add_namespace_definition("ns2", "http://www.neg.hospedajes.mir.es/altaReservaVehiculo")

      # Agrega la cabecera
      agregar_cabecera(xml_document, reg_factu_sistema_facturacion.cabecera)


      return xml_document

    end

    private

    #
    # Agrega la cabecera al XML.
    #
    def self.agregar_cabecera(xml_document, cabecera)

      cabecera_element = Nokogiri::XML::Node.new('sum:Cabecera', xml_document)

      # Obligado emision
      obligado_emision_element = Nokogiri::XML::Node.new('sum1:ObligadoEmision', xml_document)
      obligado_emision_razon_social_element = Nokogiri::XML::Node.new('sum1:NombreRazon', xml_document)
      obligado_emision_razon_social_element.content = cabecera.obligado_emision.nombre_razon
      obligado_emision_element.add_child(obligado_emision_razon_social_element)
      obligado_emision_nif_element = Nokogiri::XML::Node.new('sum1:NIF', xml_document)
      obligado_emision_nif_element.content = cabecera.obligado_emision.nif
      obligado_emision_element.add_child(obligado_emision_nif_element)
      cabecera_element.add_child(obligado_emision_element)

=begin
      if cabecera.representante
        # Representante
        obligado_representante_element = Nokogiri::XML::Node.new('sum1:Representante', xml_document)
        obligado_representante_razon_social_element = Nokogiri::XML::Node.new('sum1:NombreRazon', xml_document)
        obligado_representante_razon_social_element.content = cabecera.representante.nombre_razon
        obligado_representante_element.add_child(obligado_representante_razon_social_element)
        obligado_representante_nif_element = Nokogiri::XML::Node.new('sum1:NIF', xml_document)
        obligado_representante_nif_element.content = cabecera.representante.nif
        obligado_representante_element.add_child(obligado_representante_nif_element)
      end
=end
      # Añade la cabecera al documento XML
      xml_document.root.add_child(cabecera_element)
    end

    #
    # Agrega el registro de factura al XML
    #
    def self.agregar_registro_factura(xml_document, registro_factura)
      registro_element = Nokogiri::XML::Node.new('sum:RegistroFactura', xml_document)

      xml_document.root.add_child(registro_element)
    end

  end
end

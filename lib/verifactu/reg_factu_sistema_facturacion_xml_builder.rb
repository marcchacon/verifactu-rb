require 'nokogiri'
module Verifactu
  class RegFactuSistemaFacturacionXmlBuilder
    #
    # It creates an XML representation of the RegFactuSistemaFacturacion.
    # xml.root.to_xml
    #
    def self.build(reg_factu_sistema_facturacion)

      # Create the XML document
      xml_document = Nokogiri::XML('<sum:RegFactuSistemaFacturacion/>')
      xml_document.encoding = 'UTF-8'

      # Agrega la cabecera
      agregar_cabecera(xml_document, reg_factu_sistema_facturacion.cabecera)

      # Agrega los registros de factura
      agregar_registro_factura(xml_document, reg_factu_sistema_facturacion.registro_factura)

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

      # Añade la cabecera al documento XML
      xml_document.root.add_child(cabecera_element)
    end

    #
    # Agrega el registro de factura al XML
    #
    def self.agregar_registro_factura(xml_document, registro_factura)
      registro_element = Nokogiri::XML::Node.new('sum:RegistroFactura', xml_document)
      xml_document.root.add_child(registro_element)

      registro_factura.each do |registro|
        if registro.is_a?(Verifactu::RegistroAlta)
          # Agrega el registro de alta
          agregar_registro_alta(xml_document, registro_element, registro)
        elsif registro.is_a?(Verifactu::RegistroAnulacion)
          # Agrega el registro de anulación
          agregar_registro_anulacion(xml_document, registro_element, registro)
        else
          raise ArgumentError, "Unsupported registro type: #{registro.class}"
        end
      end

    end

    #
    # Agrega un registro de alta al XML
    #
    def self.agregar_registro_alta(xml_document, registro_element, registro)

      # Crea el nodo RegistroAlta
      registro_alta_element = Nokogiri::XML::Node.new('sum1:RegistroAlta', xml_document)
      registro_element.add_child(registro_alta_element)

      # Agrega IdVersion
      id_version_element = Nokogiri::XML::Node.new('sum1:IDVersion', xml_document)
      id_version_element.content = "1.0" # Versión 1.0 de verifactu
      registro_alta_element.add_child(id_version_element)

      # Agrega IDFactura
      id_factura_element = Nokogiri::XML::Node.new('sum1:IDFactura>', xml_document)
      id_emisor_factura_element = Nokogiri::XML::Node.new('sum1:IDEmisorFactura', xml_document)
      id_emisor_factura_element.content = registro.id_factura.id_emisor_factura
      id_factura_element.add_child(id_emisor_factura_element)
      num_serie_factura_element = Nokogiri::XML::Node.new('sum1:NumSerieFactura', xml_document)
      num_serie_factura_element.content = registro.id_factura.num_serie_factura
      id_factura_element.add_child(num_serie_factura_element)
      fecha_expedicion_element = Nokogiri::XML::Node.new('sum1:FechaExpedicionFactura', xml_document)
      fecha_expedicion_element.content = registro.id_factura.fecha_expedicion_factura
      id_factura_element.add_child(fecha_expedicion_element)
      registro_alta_element.add_child(id_factura_element)

      # Agrega otros campos necesarios del registro de alta
      # ...

    end

  end
end

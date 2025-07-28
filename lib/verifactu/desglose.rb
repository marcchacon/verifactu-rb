module Verifactu
  # Representa <sum1:DetalleDesglose>
  class DetalleDesglose
    attr_reader :impuesto, 
    :clave_regimen, 
    :calificacion_operacion, 
    :operacion_exenta, 
    :tipo_impositivo, 
    :base_imponible_o_importe_no_sujeto,
    :base_imponible_a_coste,
    :cuota_repercutida,
    :tipo_recargo_equivalencia,
    :cuota_recargo_equivalencia,

    def initialize(impuesto: nil, clave_regimen: nil, calificacion_operacion: nil, operacion_exenta: nil, tipo_impositivo: nil, base_imponible_o_importe_no_sujeto:, base_imponible_a_coste: nil, cuota_repercutida: nil, tipo_recargo_equivalencia: nil, cuota_recargo_equivalencia: nil)
      raise ArgumentError, "impuesto debe ser una de #{Verifactu::Config::L1.join(', ')} o nil" unless  impuesto.nil? || Verifactu::Config::L1.include?(impuesto)
     
      raise ArgumentError, "se necesita calificacion_operacion o operacion_exenta" if calificacion_operacion.nil? && operacion_exenta.nil?
      raise ArgumentError, "solo se puede definir calificacion_operacion o operacion_exenta, no ambos" if calificacion_operacion && operacion_exenta
      raise ArgumentError, "calificacion_operacion debe ser uno de #{Verifactu::Config::L9.join(', ')} o nil" unless calificacion_operacion.nil? || Verifactu::Config::L9.include?(calificacion_operacion)
      raise ArgumentError, "operacion_exenta debe ser uno de #{Verifactu::Config::L10A.join(', ')} o nil" unless operacion_exenta.nil? || Verifactu::Config::L10A.include?(operacion_exenta)

      raise ArgumentError, "tipo_impositivo debe ser menor a 999.99 o nil" unless tipo_impositivo.nil? || Verifactu::Helper::Validador.validar_digito(tipo_impositivo, digitos: 3)
      raise ArgumentError, "base_imponible_o_importe_no_sujeto is required" if base_imponible_o_importe_no_sujeto.nil?
      raise ArgumentError, "base_imponible_o_importe_no_sujeto debe ser un número de maximo 12 digitos antes del decimal y 2 decimales" unless Verifactu::Helper::Validador.validar_digito(base_imponible_o_importe_no_sujeto, digitos: 12)

      error_message = "cuando operacion_exenta no es nil"
      if operacion_exenta
        raise ArgumentError, "#{error_message}, tipo_impositivo debe ser nil" unless tipo_impositivo.nil?
        raise ArgumentError, "#{error_message}, cuota_repercutida debe ser nil" unless cuota_repercutida.nil?
        raise ArgumentError, "#{error_message}, tipo_recargo_equivalencia debe ser nil" unless tipo_recargo_equivalencia.nil?
        raise ArgumentError, "#{error_message}, cuota_recargo_equivalencia debe ser nil" unless cuota_recargo_equivalencia.nil?
      end
      
      if base_imponible_a_coste
        raise ArgumentError, "BaseImponibleACoste solo puede estar cumplimentado si ClaveRegimen es '06' o Impuesto es '02' (IPSI) o '05' (Otros)" unless clave_regimen == "06" || impuesto == "02" || impuesto == "05"
        raise ArgumentError, "BaseImponibleACoste debe ser un número de maximo 12 digitos antes del decimal y 2 decimales" unless Verifactu::Helper::Validador.validar_digito(base_imponible_a_coste, digitos: 12)
      end
      error_message = "cuando impuesto es #{impuesto}"
      if impuesto.nil? || impuesto == "01" # IVA
        raise ArgumentError, "#{error_message}, operacion_exenta debe ser uno de #{Verifactu::Config::L10.join(', ')} o nil" unless operacion_exenta.nil? || Verifactu::Config::L10.include?(operacion_exenta)
        raise ArgumentError, "#{error_message}, clave_regimen debe ser uno de #{Verifactu::Config::L8A.join(', ')}" unless Verifactu::Config::L8A.include?(clave_regimen)

        error_message += ", calificacion_operacion es #{calificacion_operacion}"
        if calificacion_operacion == "S1"
          raise ArgumentError, "#{error_message}, tipo_impositivo debe ser un porcentaje válido: #{Verifactu::Config::TIPO_IMPOSITIVO.join(', ')}" unless Verifactu::Config::TIPO_IMPOSITIVO.include?(tipo_impositivo)
          # La validacion de tipo impositivo por fecha se realiza en el validador de factura

          self.validar_tipo_recargo_equivalencia(tipo_recargo_equivalencia: tipo_recargo_equivalencia, tipo_impositivo: tipo_impositivo, error_message: error_message)

          raise ArgumentError, "#{error_message}, tipo_recargo_equivalencia debe ser uno de #{Verifactu::Config::TIPO_RECARGO_EQUIVALENCIA.join(', ')} o nil" unless tipo_recargo_equivalencia.nil? || Verifactu::Config::TIPO_RECARGO_EQUIVALENCIA.include?(tipo_recargo_equivalencia)

        elsif calificacion_operacion == "N1" || calificacion_operacion == "N2"
          raise ArgumentError, "#{error_message}, tipo_impositivo debe ser nil" unless tipo_impositivo.nil?
          raise ArgumentError, "#{error_message}, cuota_repercutida debe ser nil" unless cuota_repercutida.nil?
          raise ArgumentError, "#{error_message}, tipo_recargo_equivalencia debe ser nil" unless tipo_recargo_equivalencia.nil?
          raise ArgumentError, "#{error_message}, cuota_recargo_equivalencia debe ser nil" unless cuota_recargo_equivalencia.nil?
        end
      elsif impuesto == "03" # IGIC
        raise ArgumentError, "#{error_message}, operacion_exenta debe ser uno de #{Verifactu::Config::L10B.join(', ')} o nil" unless operacion_exenta.nil? || Verifactu::Config::L10B.include?(operacion_exenta)
        raise ArgumentError, "#{error_message}, clave_regimen debe ser uno de #{Verifactu::Config::L8B.join(', ')}" unless Verifactu::Config::L8B.include?(clave_regimen)
      end
      
      # Validaciones adicionales para clave_regimen
      error_message = "Cuando clave_regimen es #{clave_regimen} y el impuesto es #{impuesto}"
      case clave_regimen
      when "02" # Exportación
        if impuesto == "01" || impuesto == "03" # IVA o IGIC
          raise ArgumentError, "#{error_message}, OperacionExenta no puede ser nil" if operacion_exenta.nil?
        end
      when "03" # REBU
        if impuesto == "01" || impuesto == "03" # IVA o IGIC
          raise ArgumentError, "#{error_message}, CalificacionOperacion debe ser S1 o nil" unless calificacion_operacion.nil? || calificacion_operacion == "S1"
        end
      when "04" #  Operaciones con oro de inversión
        if impuesto == "01" || impuesto == "03" # IVA o IGIC
          raise ArgumentError, "#{error_message}, CalificacionOperacion debe ser S2 o nil" unless calificacion_operacion.nil? || calificacion_operacion == "S2"
        end
      when "06" # Grupo de entidades nivel avanzado
        if impuesto == "01" || impuesto == "03" # IVA o IGIC
          raise ArgumentError, "#{error_message}, BaseImponibleACoste no debe ser nil" if base_imponible_a_coste.nil?
          # Validacion de tipoFactura se realiza en el validador de factura
        end
      when "07" # Criterio de caja.
        if impuesto == "01" || impuesto == "03" # IVA o IGIC
          if calificacion_operacion
            invalid_calificaciones = ["S2", "N1", "N2"]
            raise ArgumentError, "#{error_message}, CalificacionOperacion no puede ser #{invalid_calificaciones.join(', ')}" if invalid_calificaciones.include?(calificacion_operacion)
          elsif operacion_exenta
            invalid_operaciones_exentas = ["E2", "E3", "E4", "E5"]
            raise ArgumentError, "#{error_message}, OperacionExenta no puede ser #{invalid_operaciones_exentas.join(', ')}" if invalid_operaciones_exentas.include?(operacion_exenta)
          end
        end
      when "08" 
        if impuesto == "01" || impuesto == "03" # IVA o IGIC
          valid_calificaciones = ["N2"]
          raise ArgumentError, "#{error_message}, CalificacionOperacion debe ser #{valid_calificaciones.join(', ')}" unless valid_calificaciones.include?(calificacion_operacion)
        end
      when "10" #Cobro por cuenta de terceros
        if impuesto == "01" || impuesto == "03" # IVA o IGIC
          valid_calificaciones = ["N1"]
          raise ArgumentError, "#{error_message}, CalificacionOperacion debe ser #{valid_calificaciones.join(', ')}" unless valid_calificaciones.include?(calificacion_operacion)
          # Validacion de tipoFactura se realiza en el validador de factura
          # Validacion de destinatario se realiza en el validador de factura
        end
      when "11" # Arrendamiento de local de negocio
        if impuesto == "01" # IVA
          valid_tipo_impositivo = ["21"]
          raise ArgumentError, "#{error_message}, TipoImpositivo debe ser #{valid_tipo_impositivo.join(', ')}" unless valid_tipo_impositivo.include?(tipo_impositivo)
        end
      # when "14" # IVA pendiente AAPP.
        # Validacion de fechaOperacion se realiza en el validador de factura
        # Validacion de destinatario se realiza en el validador de factura
        # Validacion de tipoFactura se realiza en el validador de factura
      end

      error_message = "Cuando calificacion_operacion es #{calificacion_operacion}"
      if calificacion_operacion == "S2"
        # La validacion de tipo_factura se realiza en el validador de factura
        raise ArgumentError, "#{error_message}, tipo_impositivo debe ser 0" unless tipo_impositivo == "0"
        raise ArgumentError, "#{error_message}, cuota_repercutida debe ser 0" unless cuota_repercutida == "0"
      elsif calificacion_operacion == "S1"
        raise ArgumentError, "#{error_message}, tipo_impositivo es obligatorio" if tipo_impositivo.nil?
        # Validacion de cuota_repercutida se ejecuta en el validador de factura
      end

      @impuesto = impuesto
      @clave_regimen = clave_regimen
      @calificacion_operacion = calificacion_operacion
      @operacion_exenta = operacion_exenta
      @tipo_impositivo = tipo_impositivo
      @base_imponible_o_importe_no_sujeto = base_imponible_o_importe_no_sujeto
      @base_imponible_a_coste = base_imponible_a_coste
      @cuota_repercutida = cuota_repercutida
      @tipo_recargo_equivalencia = tipo_recargo_equivalencia
      @cuota_recargo_equivalencia = cuota_recargo_equivalencia
    end

    # Validación de cuota repercutida que debe hacerse excepto si TipoRectificativa = “I” o TipoFactura “R2”, “R3”
    def validacion_cuota_repercutida()

      if cuota_repercutida.to_f * base_imponible_o_importe_no_sujeto.to_f < 0
        return false
      end

      resultado = base_imponible_o_importe_no_sujeto.to_f * tipo_impositivo.to_f / 100.0
      # Tolerancia de +/- 10 euros
      ((cuota_repercutida.to_f - resultado).abs <= 10.0)
    end

    private

    # Validación de tipo recargo equivalencia
    # Asume que impuesto es IVA y calificacion_operacion es S1
    def validar_tipo_recargo_equivalencia(tipo_recargo_equivalencia:, tipo_impositivo:, error_message: "")
      if tipo_recargo_equivalencia.nil? || tipo_recargo_equivalencia != "0"
        error_message += ", tipo_impositivo es #{tipo_impositivo}, y existe tipo_recargo_equivalencia, este debe ser uno de"

        case tipo_impositivo
        when "21"
          valid_impuestos = ["5.2", "1.75"]
          raise ArgumentError, "#{error_message} #{valid_impuestos.join(', ')}" unless valid_impuestos.include?(tipo_recargo_equivalencia)
        when "10"
          valid_impuestos = ["1.4"]
          raise ArgumentError, "#{error_message} #{valid_impuestos.join(', ')}" unless valid_impuestos.include?(tipo_recargo_equivalencia)
        when "7.5"
          valid_impuestos = ["1"]
          raise ArgumentError, "#{error_message} #{valid_impuestos.join(', ')}" unless valid_impuestos.include?(tipo_recargo_equivalencia)
        when "5"
          valid_impuestos = ["0.5", "0.62"]
          raise ArgumentError, "#{error_message} #{valid_impuestos.join(', ')}" unless valid_impuestos.include?(tipo_recargo_equivalencia)
        when "4"
          valid_impuestos = ["0.5"]
          raise ArgumentError, "#{error_message} #{valid_impuestos.join(', ')}" unless valid_impuestos.include?(tipo_recargo_equivalencia)
        when "2"
          valid_impuestos = ["0.26"]
          raise ArgumentError, "#{error_message} #{valid_impuestos.join(', ')}" unless valid_impuestos.include?(tipo_recargo_equivalencia)
        when "0"
          valid_impuestos = Verifactu::Config::TIPO_RECARGO_EQUIVALENCIA
          raise ArgumentError, "#{error_message} #{valid_impuestos.join(', ')}" unless valid_impuestos.include?(tipo_recargo_equivalencia)
        else
          raise ArgumentError, "tipo_impositivo debe ser uno de #{Verifactu::Config::TIPO_IMPOSITIVO.join(', ')}"
        end
      end
    end


  end
end

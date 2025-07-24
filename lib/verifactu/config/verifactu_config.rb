module Verifactu
    module Config
        # Listas de valores permitidos para los campos
        # (https://www.agenciatributaria.es/static_files/AEAT_Desarrolladores/EEDD/IVA/VERI-FACTU/DsRegistroVeriFactu.xlsx)
        L1 = ['01', '02', '03']
        L2 = ['F1', 'F2', 'F3', 'R1', 'R2', 'R3', 'R4', 'R5']
        L3 = ['S', 'I']
        L4 = ['S', 'N']
        L5 = ['S', 'N']
        L6 = ['D', 'T']
        L7 = ['02', '03', '04', '05', '06', '07']
        L8A = ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19', '20'] #DESCRIPCIÓN DE LA CLAVE DE RÉGIMEN PARA DESGLOSES DONDE EL IMPUESTO DE APLICACIÓN ES EL IVA
        L8B = ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15', '16', '17', '18', '19'] #DESCRIPCIÓN DE LA CLAVE DE RÉGIMEN PARA DESGLOSES DONDE EL IMPUESTO DE APLICACIÓN ES EL IGIC
        L9 = ['S1', 'S2', 'N1', 'N2']
        L10 = ['E1', 'E2', 'E3', 'E4', 'E5']
        L12 = ['01']
        L14 = ['S', 'N']
        L15 = ['1.0'] # Valores de versiones aceptadas de Verifactu
        L16 = ['E', 'D', 'T']
        L17 = ['N', 'S', 'X']
        L1E = ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12', '13', '14', '15', '90']
        L2E = ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '90']
        L3E = ['S', 'N']
        L4E = ['D', 'T']

        PAISES_PERMITIDOS = ['DE', 'AT', 'BE', 'CY', 'CZ', 'HR', 'DK', 'SK', 'SI', 'ES', 'EE', 'FI', 'FR', 'EL', 'GB', 'XI', 'NL', 'HU', 'IT', 'IE', 'LV', 'LT', 'LU', 'MT', 'PL', 'PT', 'SE', 'BG', 'RO']

        ID_VERSION = ENV['VERIFACTU_ID_VERSION'] || L15.first

    end
end
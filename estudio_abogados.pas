PROGRAM final_estudio_abogados;
USES CRT;

TYPE
    juicios = RECORD
            nj: integer;
            id: integer;
            juz: integer;
            anio: integer;
            car: string;
            nc: integer;
            cli: string;
            est: char;
    END;

    actuaciones = RECORD
                id: integer;
                desc: string;
                cht: real;
                gast: real;
    END;

VAR
   archivo_juicios: FILE OF juicios;
   archivo_actuaciones: FILE OF actuaciones;
   registro_juicios: juicios;
   registros_actuaciones: actuaciones;

BEGIN


END.
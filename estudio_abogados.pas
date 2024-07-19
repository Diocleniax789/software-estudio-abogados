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

PROCEDURE crea_archivo_juicios;
 BEGIN
 rewrite(archivo_juicios);
 close(archivo_juicios);
 END;

PROCEDURE crea_archivo_actuaciones;
 BEGIN
 rewrite(archivo_actuaciones);
 close(archivo_actuaciones);
 END;

PROCEDURE menu_principal;
VAR
 op: integer;
 BEGIN
 REPEAT
 writeln('SOFTWARE DE ESTUDIO DE ABOGADOS v.0');
 writeln('-----------------------------------');
 writeln();
 writeln('1. Cargar juicio');
 writeln('2. Cargar actuacion');
 writeln('3. Listado de un juicio');
 writeln('4. Gastos totales');
 writeln('5. Modificar estado');
 writeln('6. Salir');
 writeln();
 writeln('-------------------------');
 write('Seleccione opcion: ');
 readln(op);
 CASE op OF
      1:BEGIN
        clrscr;
        carga_juicio;
        END;
      2:BEGIN
        clrscr;
        carga_actuacion;
        END;
      3:BEGIN
        clrscr;
        listado;
        END;
      4:BEGIN
        clrscr;
        gastos;
        END;
      5:BEGIN
        clrscr;
        modificar;
        END;
 END;
 UNTIL (op = 6);
 END;

BEGIN
assign(archivo_juicios,'C:\Users\JULIO\Desktop\software-estudio-abogados\juicios.dat');
assign(archivo_actuaciones,'C:\Users\JULIO\Desktop\software-estudio-abogados\actuaciones.dat');
crea_archivo_juicios;
crea_archivo_actuaciones;
menu_principal;
END.

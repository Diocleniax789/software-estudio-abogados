PROGRAM final_estudio_abogados;
USES CRT;

TYPE
    juicios = RECORD
            numero_juicio: integer;
            identificador: integer;
            juzgado: integer;
            anio: integer;
            caratula: string;
            numero_cliente: integer;
            cliente: string;
            estado: string;
    END;

    actuaciones = RECORD
                identificador: integer;
                descripcion: string;
                cant_horas_trabajadas: real;
                gastos: real;
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

PROCEDURE carga_juicio;
VAR
 op_1: string;
 op: integer;
 BEGIN
 REPEAT
 clrscr;
 reset(archivo_juicios);
 textcolor(lightcyan);
 writeln('CARGUE AQUI LOS DATOS DEL JUICIO');
 writeln('--------------------------------');
 writeln();
 write('>>> Ingrese numero de juicio: ');
 readln(registro_juicios.numero_juicio);
 writeln();
 write('>>> Ingrese numero identificador: ');
 readln(registro_juicios.identificador);
 writeln();
 write('>>> Ingrese numero de juzgado: ');
 readln(registro_juicios.juzgado);
 writeln();
 write('>>> Ingrese anio del juicio: ');
 readln(registro_juicios.anio);
 writeln();
 write('>>> Ingrese caratula: ');
 readln(registro_juicios.caratula);
 writeln();
 write('>>> Ingrese numero cliente: ');
 readln(registro_juicios.numero_cliente);
 writeln();
 write('>>> Ingrese nombre cliente: ');
 readln(registro_juicios.cliente);
 writeln();
 writeln('>>> Seleccione estado del juicio: ');
 writeln();
 writeln('1. Activo');
 writeln('2. Cerrado');
 writeln();
 write('Seleccione opcion: ');
 readln(op);
 CASE op OF
      1:BEGIN
        registro_juicios.estado:= 'activo';
        END;
      2:BEGIN
        registro_juicios.estado:= 'cerrado';
        END;
 END;
 seek(archivo_juicios,filesize(archivo_juicios));
 write(archivo_juicios, registro_juicios);
 textcolor(lightgreen);
 writeln();
 writeln('==================================');
 writeln('*** REGISTRO CARGADO CON EXITO ***');
 writeln('==================================');
 writeln();
 close(archivo_juicios);
 REPEAT
 textcolor(lightcyan);
 write('Desea volver a cargar otro registro[s/n]?: ');
 readln(op_1);
 IF (op_1 <> 's') AND (op_1 <> 'n') THEN
  BEGIN
  textcolor(lightred);
  writeln();
  writeln('///////////////////////////////////////');
  writeln('X VALOR INCORRECTO. VUELVA A INGRESAR X');
  writeln('///////////////////////////////////////');
  writeln();
  END;
 UNTIL (op_1 = 's') OR (op_1 = 'n');
 UNTIL (op_1 = 'n');
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
   {   2:BEGIN
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
        END;   }
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

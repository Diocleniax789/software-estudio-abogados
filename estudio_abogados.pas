PROGRAM final_estudio_abogados;
USES CRT;

CONST
     tiempo = 2000;

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
                cant_horas_trabajadas: integer;
                gastos: integer;
    END;

VAR
   archivo_juicios: FILE OF juicios;
   archivo_actuaciones: FILE OF actuaciones;
   registro_juicios: juicios;
   registro_actuaciones: actuaciones;

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

FUNCTION verificar_estado_archivo_actuaciones(): boolean;
 BEGIN
 reset(archivo_actuaciones);
 IF filesize(archivo_actuaciones) = 0 THEN
    verificar_estado_archivo_actuaciones:= true
 ELSE
     verificar_estado_archivo_actuaciones:= false;
 close(archivo_actuaciones);
 END;

FUNCTION vericar_estado_archivo_juicio(): boolean;
 BEGIN
 reset(archivo_juicios);
 IF filesize(archivo_juicios) = 0 THEN
    vericar_estado_archivo_juicio:= true
 ELSE
     vericar_estado_archivo_juicio:= false;
 close(archivo_juicios);
 END;

PROCEDURE ordena_archivo_juicios;
VAR
 i,j: integer;
 reg_aux: juicios;
 BEGIN
 FOR i:= 0 TO filesize(archivo_juicios) - 2 DO
  BEGIN
  FOR j:= i + 1 TO filesize(archivo_juicios) - 1 DO
   BEGIN
   seek(archivo_juicios, i);
   read(archivo_juicios,registro_juicios);
   seek(archivo_juicios, j);
   read(archivo_juicios, reg_aux);
   IF registro_juicios.numero_cliente > reg_aux.numero_cliente THEN
    BEGIN
    seek(archivo_juicios, i);
    write(archivo_juicios, reg_aux);
    seek(archivo_juicios, j);
    write(archivo_juicios, registro_juicios);
    END;
   END;
  END;
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
 ordena_archivo_juicios;
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

PROCEDURE carga_actuacion;
VAR
 op_1: string;
 BEGIN
  REPEAT
  clrscr;
  textcolor(yellow);
  reset(archivo_actuaciones);
  writeln('CARGA LOS DATOS DE LA ACTUACION AQUI');
  writeln('------------------------------------');
  writeln();
  write('>>> Ingrese numero identificador: ');
  readln(registro_actuaciones.identificador);
  writeln();
  write('>>> Ingrese descripcion: ');
  readln(registro_actuaciones.descripcion);
  writeln();
  write('>>> Ingrese cantidad de horas trabajadas: ');
  readln(registro_actuaciones.cant_horas_trabajadas);
  writeln();
  write('>> Ingrese gastos: ');
  readln(registro_actuaciones.gastos);
  seek(archivo_actuaciones,filesize(archivo_actuaciones));
  write(archivo_actuaciones,registro_actuaciones);
  writeln();
  textcolor(lightgreen);
  writeln('==================================');
  writeln('*** REGISTRO CARGADO CON EXITO ***');
  writeln('==================================');
  writeln();
  close(archivo_actuaciones);
  REPEAT
  textcolor(yellow);
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

FUNCTION busca_num_jui(num_jui: integer): boolean;
VAR
 f: boolean;
 BEGIN
 REPEAT
 read(archivo_juicios,registro_juicios);
 IF num_jui = registro_juicios.numero_juicio THEN
  f:= true;
 UNTIL eof(archivo_juicios) OR (f = true);
 IF f = true THEN
    busca_num_jui:= true
 ELSE
    busca_num_jui:= false;
 END;

PROCEDURE muestra_actuaciones(id: integer);
 BEGIN
 reset(archivo_actuaciones);
 WHILE NOT eof(archivo_actuaciones) DO
  BEGIN
  read(archivo_actuaciones,registro_actuaciones);
  IF id = registro_actuaciones.identificador THEN
   BEGIN
   writeln('-------------------------------');
   writeln('Identificador: ',registro_actuaciones.identificador);
   writeln('Descripcion: ',registro_actuaciones.descripcion);
   writeln('Cantidad de horas trabajadas: ',registro_actuaciones.cant_horas_trabajadas);
   writeln('Gastos: ',registro_actuaciones.gastos);
   END;
  END;
 close(archivo_actuaciones);
 END;

PROCEDURE listado;
VAR
 op: string;
 num_jui,id: integer;
 BEGIN
 IF vericar_estado_archivo_juicio = true THEN
  BEGIN
  textcolor(lightred);
  writeln();
  writeln('////////////////////////////////////////////////////');
  writeln('X EL ARCHIVO JUICIOS ESTA VACIO. INTENTE MAS TARDE X');
  writeln('////////////////////////////////////////////////////');
  delay(tiempo);
  END
 ELSE
  BEGIN
  REPEAT
  clrscr;
  reset(archivo_juicios);
  textcolor(lightcyan);
  writeln('PARA VER EL LISTADO SOLO INGRESE UN NUMERO DE JUICIO EXISTENTE');
  writeln('--------------------------------------------------------------');
  writeln();
  writeln('>>> Ingrese numero de juicio: ');
  readln(num_jui);
  IF busca_num_jui(num_jui) = true THEN
   BEGIN
   textcolor(green);
   writeln('DATOS:');
   writeln('------');
   writeln();
   writeln('Numero identificador: ',registro_juicios.identificador);
   writeln('Numero juzgado: ',registro_juicios.juzgado);
   writeln('Anio del juicio: ',registro_juicios.anio);
   writeln('Caratula: ',registro_juicios.caratula);
   writeln('Numero de cliente: ',registro_juicios.numero_cliente);
   writeln('Nombre del cliente: ',registro_juicios.cliente);
   writeln('Estado: ',registro_juicios.estado);
   id:= registro_juicios.identificador;
   muestra_actuaciones(id);
   writeln();
   END
  ELSE
   BEGIN
   textcolor(lightred);
   writeln();
   writeln('//////////////////////////////////');
   writeln('X NO EXISTE ESE NUMERO DE JUICIO X');
   writeln('//////////////////////////////////');
   writeln();
   END;
  close(archivo_juicios);
  REPEAT
  textcolor(yellow);
  write('Desea volver a ver otro listado[s/n]?: ');
  readln(op);
  IF (op <> 's') AND (op <> 'n') THEN
   BEGIN
   textcolor(lightred);
   writeln();
   writeln('///////////////////////////////////////');
   writeln('X VALOR INCORRECTO. VUELVA A INGRESAR X');
   writeln('///////////////////////////////////////');
   writeln();
   END;
  UNTIL (op = 's') OR (op = 'n');
  UNTIL (op = 'n');
  END;
 END;

PROCEDURE gastos;
VAR
 tot_gastos,tot_cht,tot: integer;
 BEGIN
 IF verificar_estado_archivo_actuaciones = true THEN
  BEGIN
  textcolor(lightred);
  writeln();
  writeln('////////////////////////////////////////////////////////');
  writeln('X EL ARCHIVO ACTUACIONES ESTA VACIO. INTENTE MAS TARDE X');
  writeln('////////////////////////////////////////////////////////');
  delay(tiempo);
  END
 ELSE
  reset(archivo_actuaciones);
  tot_gastos:= 0;
  tot_cht:= 0;
  WHILE NOT eof(archivo_actuaciones) DO
   BEGIN
   read(archivo_actuaciones,registro_actuaciones);
   tot_gastos:= tot_gastos + registro_actuaciones.gastos;
   tot_cht:= tot_cht + registro_actuaciones.cant_horas_trabajadas;
   END;
   tot:= tot_gastos div tot_cht;
  close(archivo_actuaciones);
  writeln('TOTAL DE GASTOS: ',tot);
  writeln();
  writeln('Presione enter para salir...');
  readln();
 END;

PROCEDURE menu_principal;
VAR
 op: integer;
 BEGIN
 REPEAT
 clrscr;
 textcolor(white);
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
   {   5:BEGIN
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

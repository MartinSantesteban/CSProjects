> En este mismo directorio se encuentran los tres codigos fuente necesarios. Para poder correrlos, primero deben ser compilados.
  Para compilar uno de los archivos, hace falta tener instalado gcc o g++ (o cualquier compilador de preferencia) y ejecutar en una terminal:

g++ <nombreDelArchivo> -o <archivoDeSalida>

> Donde nombreDelArchivo es uno de los archivos .cpp en el directorio, y archivoDeSalida es el nombre del archivo objeto generado por la instruccion.
  Notar que archivoDeSalida es el nombre que usted quiera.

> Una vez compilado el archivo fuente, se habrá creado un archivo en el directorio con el nombre archivoDeSalida.out.
  Para poder ejecutar el programa, debe ejecutar en la terminal la siguiente instruccion:

./archivoDeSalida.out

> Luego, podrá ingresar los parametros que necesita el programa usando la terminal. Sin embargo, si tiene un archivo .txt (por ejemplo parametros.txt) donde ya se encuentran todos 
  los parametros que requiere el archivo, puede simplemente ejecutar la siguiente instruccion.

./archivoDeSalida.out < parametros.txt

> Al hacer esto le estamos pasando toda la informacion que el programa espera recibir por la entrada estandar. Luego, deberia poder ver la salida del programa en la terminal.

-----------------------------------------------------------------------------------------------------------------------------------------------------------------

> En el caso en que desee pasarle parametros por la terminal al archivo objeto del primer ejercicio, se los debe pasar de la siguiente forma:

m n
f1 c1 f2 c2 f3 c3
...
0 0

> Donde m y n hacen referencia a las dimensiones de la grilla y los siguientes seis numeros a las coordenadas de las posiciones checkpoint. Puede pasar muchos casos de test de esta forma, teniendo en cuenta que si   
  se lee 0 0 el programa termina.

------------------------------------------------------------------------------------------------------------------------------------------------------------------

> Para poder correr el archivo objeto del segundo ejercicio, por cada caso de test se le debe pasar la cnatidad de aspersores (n) la longitud del terreno (l) y el ancho del mismo (w).

n l w
...

> Y a continuacion (...) el programa requiere n lineas con dos enteros, que denotan la posicion del aspersor y su radio de operacion. 

-----------------------------------------------------------------------------------------------------------------------------------------------------------------

> Si se desea ejecutar el archivo objeto del tercer ejercicio, se le debe pasar al programa por entrada estandar tres enteros, igual al ejercicio anterior.

n l w

> Luego, a continuacion se reuqiere de n lineas con tres enteros: posicion del aspersor y radio de operacion, junto con un tercer entero que denota al costo del mismo.

-----------------------------------------------------------------------------------------------------------------------------------------------------------------

Tener en cuenta, que tanto en el segundo como en el tercer caso, se espera que l y w sean numeros que puedan representarse con por lo menos 4 Bytes.

%direccion(?Dir)
direccion(derecha).
direccion(arriba).
direccion(abajo).
direccion(izquierda).

%contenidoValido(?Cont)
contenidoValido(pared).
contenidoValido(hielo).
contenidoValido(tesoro).
contenidoValido(tierra).

%siguiente(+X,+Y,?Dir,?X2,?Y2) 
%   Por cada dirección posible, se define el movimiento que se realiza en el eje correspondiente.
siguiente(X, Y, derecha, X2, Y) :- X2 is X+1.
siguiente(X, Y, arriba, X, Y2) :- Y2 is Y-1.
siguiente(X, Y, abajo, X, Y2) :- Y2 is Y+1.
siguiente(X, Y, izquierda, X2, Y) :- X2 is X-1.

%dimensiones(+Laberinto, ?Columnas, ?Filas)
%   Usamos la primera fila para saber la cantidad de columnas 
%   y contamos la cantidad de filas directamente  sumandole la que sacamos
dimensiones([X|L], C, F) :- length(L, F1), length(X, C), F is F1+1.

%esLaberinto(+L)
%   Vemos que todas las filas tengan el mismo tamaño. Ademas antes vemos que la cantidad de columnas sea por lo menos 1
esLaberinto([PrimeraFila|L]) :- dimensiones(L, C, F), C>0, forall(member(X, L), (length(X, N), length(PrimeraFila, N))).

%celda(+(X, Y), +Laberinto, ?Contenido)
%   El primer nth1 nos da la fila y el segundo nos da el elemento
celda((X, Y), L, Cont) :- nth1(Y, L, Fila), nth1(X, Fila, Cont).

%tesoros(+Laberinto,-Tesoros)
%   buscamos todas las celdas aprovechando que celda es reversible en la coordenada, porque nth es reversible en el índice
tesoros(L, T) :- findall((X, Y), celda((X, Y), L, tesoro), T).

%paso(+CoordInicial,+Dir,+Laberinto,-Recorrido)
%   Si no hay siguiente celda, no se mueve asi que resulta en []
%   Si hay siguiente celda pero no resbala, la lista de pasos es sólo la siguiente celda
%   Si resbala, se agrega la siguiente celda y se ve recursivamente los pasos desde ahí
%   Se hizo de tal manera de que sean mutuamente exclusivos
paso(CI, Dir, L, []) :- not(siguienteCelda(CI, Dir, L, _)).
paso(CI, Dir, L, [R0]) :- siguienteCelda(CI, Dir, L, R0),  seDetiene(R0, L).
paso(CI, Dir, L, [R0|R]) :- siguienteCelda(CI, Dir, L, R0),  not(seDetiene(R0, L)), paso(R0, Dir, L, R).

%siguienteCelda(+CoordInicial, ?Dir, +Laberinto, ?Siguiente) <- Funcion aux
%   Verifica que la siguiente celda en esa dirección esta en el tablero al pedir el contenido y se pide que no sea una pared. 
%   No hay problema en hacer not de este predicado ya que el tablero es finito y la 
%   posibilidad de contenidos/direcciones también esta acotada. Se comporta como un not de logica
siguienteCelda((X, Y), Dir, Lab, (X2, Y2)) :- siguiente(X, Y, Dir, X2, Y2), celda((X2, Y2), Lab, Cont), Cont \= pared.

% ¿Este predicado es o no reversible en cada uno de sus parámetros?
%   Direccion es reversible porque no es necesario instanciarlo en siguienteCelda, ya que es reversible en siguiente. 
%   Coordenada incial no es reversible, ya que se debe instanciar al usar siguienteCelda porque los predicados siguiente y celda necesitan tenerla instanciada.
%   Laberinto no es reversible, ya que debe ser instanciado al usar siguienteCelda, y esta la necesita instanciada para poder usar correctamente celda.
%   Recorrido es reversible, ya que puede tratar de unificarse aun estando instanciado. 


%seDetiene(+Coord, +Lab)
%   Se detiene sii la celda no es hielo
seDetiene(Coord, Lab) :- celda(Coord, Lab, Cont), Cont \= hielo .

%caminoDesde(+Laberinto, +CoordInicial, ?Dir, -Camino, +Longitud)
%   hacemos recursion en la cantidad de pasos(longitud)
caminoDesde(_,_,_,[],0). % Caso base, no hay pasos.  Por lo tanto el camino es []
caminoDesde(Lab,Coord,Dir,Camino,Long) :- %   Y para el caso recursivo usamos el predicado paso concatenando esto al camino completo
                Long > 0, 
                SigLong is Long-1, 
                paso(Coord, Dir,Lab,Act),
                last(Act,Sig),
                caminoDesde(Lab,Sig,_,SigCamino,SigLong ),
                append(Act,SigCamino,Camino).

%solucion(+Laberinto, -Camino)
%   Agregamos un parámetro auxiliar para poder determinar la longitud del camino
%   Una solución es cualquier camino desde la primera columna hasta la última.
%   Usamos la cota de que un camino no puede tener cantidad de pasos mayor a la cantidad de celdas del laberinto
solucion(L,Camino,Long) :- 
                 dimensiones(L,C,F),
                 PasosMax is C * F, 
                 between(1,PasosMax,Long),
                 between(1,F,Y),
                 caminoDesde(L,(0,Y),derecha,Camino,Long),
                 last(Camino,(C,_)).

solucion(L,Camino) :- solucion(L,Camino,_). % Finalmente, el precidado solucion/2 es el que se pide en el enunciado, en el cual no importa la longitud del camino

%solucionOptima(+Laberinto, -Camino)

%   Primero, hacemos un predicado auxiliar solucionTesoros para obtener todas las soluciones que pasan por todos los tesoros.
solucionTesoros(L, Camino, Pasos) :- 
                              tesoros(L, T),
                              solucion(L,Camino,Pasos),
                              list_to_set(Camino, CaminoSet),
                              list_to_set(T, Tset),
                              subset(Tset, CaminoSet).
%   En caso de no haber tesoros, tesoros instancia a T en la lista vacia. Luego, como Tset se instancia en 
%   el conjunto vacio, cualquier camino será una solucion con todos los tesoros. 

%   También, hacemos un predicado auxiliar largoMinimo para obtener la longitud minima de solucionTesoros.
largoMinimo(L, LongMin) :- solucionTesoros(L,_,LongMin),!. 
%    La primer solucion tiene longitud minima porque las soluciones se van instanciando crecientemente con respecto a la longitud del camino.
%    Se hizo uso de ! para poder instanciar LongMin sólo en la primer solución. 

solucionOptima(L,Camino) :- largoMinimo(L,LargoMin), solucionTesoros(L, Camino, LargoMin). 
%    En caso de no haber tesoros se devuelve el camino solucion de longitud minima.




%%%%%%%%%%%%%%%% ESTRUCTURAS DE EJEMPLO %%%%%%%%%%%%%%%%%%%%%%%%%

laberintoBobo([[tierra]]).

laberintoBobo2([[tierra,tierra]]).

laberinto0([[pared,pared,pared,pared,pared,pared],[tierra,tierra,tierra,tierra,tierra,tierra],[pared,pared,pared,pared,pared,pared]]).

laberinto1([[tesoro,tierra,tesoro,tierra,tierra,hielo,tierra,tesoro,tierra,pared,tesoro,tierra],[tierra,tierra,hielo,tesoro,tierra,pared,pared,tesoro,tesoro,pared,pared,tesoro],[tierra,pared,tierra,tierra,tesoro,tesoro,pared,tierra,pared,tierra,tesoro,hielo],[tierra,tesoro,tesoro,tesoro,pared,tierra,tierra,tierra,hielo,hielo,tierra,tierra]]).

laberinto2([[tierra,tesoro,tierra],
            [hielo,tierra,pared]]).

laberinto3([[tierra,tierra,tierra,tesoro],[pared,tierra,hielo,pared]]).

laberinto4([[tierra,tierra,hielo,pared],
            [pared,tesoro,tierra,pared],
            [pared,tesoro,hielo,tierra]]).

laberinto5([[tierra,tierra,hielo,pared],
            [pared,hielo,tesoro,pared],
            [pared,hielo,pared,pared],
            [pared,tesoro,hielo,tierra]]).

laberinto6([[tierra,hielo,tesoro],
            [tierra,hielo,tesoro]]).

laberinto7([[tierra,hielo,tesoro],
            [tierra,tesoro,tierra]]).

laberinto8([[tierra,tierra,pared],
            [pared,tesoro,pared],
            [tierra,tierra,pared],
            [tesoro,pared,pared],
            [tierra,hielo,tierra]]).

laberinto9([[tierra,hielo,tierra],
            [pared,tesoro,tierra]]).

laberintoChico([[tierra,hielo,tierra],
            [pared,pared,tierra]]).


laberintoFila([[tierra,hielo,tierra]]).

laberintoSinTesoros([[tierra,tierra,pared],
                    [pared,hielo,pared],
                    [tierra,tierra,pared],
                    [hielo,pared,pared],
                    [tierra,hielo,tierra]]).

noLaberinto0([]).
noLaberinto1([[]]).
noLaberinto2([[_,_],[]]).
noLaberinto3([[piedra,papel,tijera]]).


%%%%%%%%%%%%%%%%%%%%%%%%% TESTS %%%%%%%%%%%%%%%%%%%%%%%%%

test(1) :- direccion(_).

% siguiente
test(2) :- siguiente(1,4,derecha,2,4), siguiente(1,4,abajo,1,5).
test(10) :- siguiente(4, 9, izquierda, 3, 9), siguiente(7, 3, arriba, X, Y), X=7, Y=2.
test(11) :- siguiente(4, 9, D, X, Y), D=izquierda, X=3, Y=9.
test(12) :- siguiente(4, 9, D, X, Y), D=arriba, X=4, Y=8.

% dimensiones
test(3) :- laberinto0(L), dimensiones(L,6,3).
test(13) :- dimensiones([[tierra,hielo,tierra], [pared, tierra, tesoro]], X, Y), X = 3, Y = 2. 

% esLaberinto
test(4) :- laberinto1(L), esLaberinto(L), noLaberinto2(NL), not(esLaberinto(NL)).
test(14) :- noLaberinto0(NL0), not(esLaberinto(NL0)), noLaberinto1(NL1), not(esLaberinto(NL1)), noLaberinto3(NL3), not(esLaberinto(NL3)).

% celda
test(15) :- laberinto6(L), celda((1, 2), L, Cont), Cont = tierra. 

% tesoros
test(16) :- laberinto4(L), tesoros(L, T), T=[(2, 2), (2, 3)].
test(17) :- laberinto0(L), tesoros(L, T), T=[].

% paso
test(5) :- laberinto4(L), findall(XS,paso((1,1),derecha,L,XS),[[(2,1)]]).
test(6) :- laberinto4(L), paso((2,3),derecha,L,[(3,3),(4,3)]).
test(7) :- laberinto4(L), paso((2,3),abajo,L,[]).

% caminoDesde
test(8) :- laberinto1(L), findall(Camino,caminoDesde(L, (1,1), _, Camino, 1),XS),msort(XS,[[(1,2)],[(2,1)]]).
test(18) :- laberinto4(L), findall(Camino,caminoDesde(L, (1,1), _, Camino, 2),XS),msort(XS,[[(2,1),(1,1)],[(2,1),(2,2)],[(2,1),(3,1)]]).
test(19) :- laberinto5(L), findall(Camino,caminoDesde(L, (2,4), _, Camino, 1),XS),msort(XS,[[(2,3),(2,2),(2,1)],[(3,4),(4,4)]]). %resbala 2 veces

% solucion
test(9) :- laberintoBobo(L), solucion(L, S), S = [(1, 1)].
test(20) :- laberintoFila(L), solucion(L,S), S = [(1,1),(2,1),(3,1)].
test(21) :- laberintoChico(L), solucion(L,S), S = [(1,1),(2,1),(3,1),(3,2)]. % entre otras soluciones

% solucionOptima
test(22) :- laberinto8(L), findall(Camino, solucionOptima(L,S),XS),msort(XS, [[(1,1),(2,1),(2,2),(2,3),(1,3),(1,4),(1,5),(2,5),(2,6)],
                                                                              [(1,3),(2,3),(2,2),(2,3),(1,3),(1,4),(1,5),(2,5),(2,6)]]).
test(23) :- laberinto9(L),findall(Camino, solucionOptima(L,S),XS),msort(XS, [[(1,1),(2,1),(3,1), (3,2),(2,2),(3,2)]]). 
test(24) :- laberintoSinTesoros(L), solucionOptima(L, C), length(C, 3). % sin tesoros devolvemos la solucion mas corta.                                                                          


tests :- forall(between(1,24,N), test(N)).


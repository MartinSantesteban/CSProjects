natural(cero).
natural(suc(N)) :- natural(N).

% el tercer parametro es el valor de retorno
suma(X,cero,X) :- natural(X).
suma(X,suc(Y),suc(Z)) :- suma(X,Y,Z).

% resta
resta(X,cero,X).
resta(X,suc(Y),Z) :- resta(X,Y,suc(Z)).

% entre(+X,+Y,-Z)
entre(X,Y,X) :- X =< Y. % aca primero unifica X con Z, le das ; y evalua entre(X + 1, Y, Z), unifica Z con X + 1...
entre(X,Y,Z) :- X < Y, X1 is X + 1, entre(X1,Y,Z).

% long(+L,-Res)

%long([],cero).
%long([_|XS],suc(Z)) :- long(XS, Z).

long([],0).
long([_|XS], N1) :- long(XS,N),  N1 is N + 1.

% sinConsecRep

sinConsecRep([],[]).
sinConsecRep([X],[X]).
sinConsecRep([X,Y|L],[X,Y|Z]) :- X \= Y, sinConsecRep([Y|L],[Y|Z]). %Tengo que ir de a uno, si no agrego Y a L y Z, "recorto" de 2 en 2 y la instancia [1,2,2] se evalua mal.
sinConsecRep([X,X|L],[X|Z]) :- sinConsecRep([X|L],[X|Z]).

% append(?L1,?L2,?L3)

% prefijo(+Lista, ?Pref)
prefijo(L,P) :- append(P,_,L). % si P appendeado a alguien da L, entonces es prefijo.

% EL _ : Aca hay una variable que se va a instanciar en algun valor pero no la voy a usar.

% Sin usar append
%prefijo([],_).
%prefijo([X|L],[Y|Z]):- X =:= Y, prefijo(L,Z).

%sufijo(+Lista, ?Suf)
sufijo(L,S) :- append(_,S,L).

%sublista(+Lista,?Subl)
sublista(_,[]).
sublista(L,[S|SS]) :- sufijo(X,[S|SS]), prefijo(L,X).

%insertar(?X,?L,?LconX)
insertar(X,L,LX) :- append(P,S,L),append(P,[X|S],LX).
% si cambio los append de orden, en uno genero SOverflow, y en el otro no. Es pq si pongo al append de LX primero se va a poner a generar infinitos sufijos de LX que no va a estar instanciada. 

%permutacion(+L,?P)
permutacion(L,P) :-
% [GUIA DE EJERCICIOS]

padre(juan, carlos).
padre(juan, luis).
padre(carlos, daniel).
padre(carlos, diego).
padre(luis, pablo).
padre(luis, manuel).
padre(luis, ramiro).


padre(javier,tata).
padre(tata,fernando).
padre(fernando, martin).

abuelo(X,Y) :- padre(X,Z), padre(Z,Y).

hijo(X,Y) :- padre(Y,X).
hermano(X,Y) :- padre(Z,X), padre(Z,Y).

descendiente(X,Y) :- hijo(X,Y).
descendiente(X,Y) :- hijo(X,Z), descendiente(Z,Y).

ancestro(X, X).
ancestro(X, Y) :- ancestro(Z, Y), padre(X, Z).

% ancestro(juan,X) -> ancestro(juan,X){X <- Juan}.
% ancestro(Z,Y), padre(X, Z){X <- juan, Y <- X} = ancestro(Z,X), padre(juan, Z) -> unifica ancestro(Z,X) con ancestro(X,X) con la sust {Z <- X, X <- X} y queda el goal nuevo padre(juan,X)

% padre(Juan, X) lo unifica con padre(juan,carlos) con {X <- carlos} y queda el goal vacio. 

% si le pedis ; backtrackea a tener que unificar  ancestro(Z,X), padre(juan, Z) pero en lugar de unificar con ancestro(X,X) unifica con la linea 25 y queda la resolvente 
% ancestro(Z2,X), padre(Z, Z2)

natural(0).
natural(suc(X)) :- natural(X).

menorOIgual(X, X) :- natural(X).
menorOIgual(X, suc(Y)) :- menorOIgual(X,Y). % Si estuvieran ddadas vuelta las lines 39 y 38, se unifica (en la consulta menorOIgual(0,X)) a X con suc(Y), queda goal nuevo menorOIgual(0,Y) y unifica a Y2 con suc(Y) y asi sucecivamente.

% [ OPERACIONES SOBRE LISTAS ]

%concatenar(?Lista1,?Lista2,?Lista3)
concatenar([],L2,L2).
concatenar([X|L1],L2,[X|L3]) :- concatenar(L1, L2, L3).

%last(?L, ?U).
%last([X], X).
%last([_|XS], X) :- last(XS,X).
last(L,U) :- append(_,[U],L).


%reverse(+L, -L1).
reverse([],[]).
reverse(L,[X|L1]) :- last(L,X), append(L2,[X],L), reverse(L2,L1).

%prefijo(?P, +L)
prefijo(P,L) :- append(P,_,L).

%sufijo(?P, L)
sufijo(P,L) :- append(_,P,L).

%sublista(?P, L)
sublista(P,L) :- append(S,_,L),append(_,P,S).

%member(?X,L)
%member(X,[X|L]).
%member(X,[Y|L]) :- X \= Y, member(X,L).
member(X,L) :- sublista([X],L).

%aplanar(+Xs, -Ys)
aplanar([],[]).
aplanar([[]|XS],YS) :- aplanar(XS,YS).
aplanar([[L|LS]|XS], YS) :- aplanar([L|LS], Y), aplanar(XS, R), append(Y,R,YS).  
aplanar([X|XS], [X|YS]) :- aplanar(XS, YS).

%palindromo(+L, ?L|)
palindromo(XS, YS) :- reverse(XS,XR), append(XS,XR,YS).

%iesimo(?I, +L, -X) <- si hago la consulta sin instanciar a I, siempre unifica con I = 0 y devuelve el primer elemento. Si pido ; va a unificar con la segunda
iesimo(0, [X|_], X).
iesimo(I, [_|LS], X) :- iesimo(I2, LS, X), I is I2 + 1. 

%interseccion(+L1, +L2, -L3)
interseccion([],_,[]).
interseccion([X|XS], YS, [X|L]) :- member(X,YS), interseccion(XS, YS, L). % acordate que cuando hay un fail, backtrackea y sigue unificando 
interseccion([_|XS], YS, L) :- interseccion(XS, YS, L). 

% long(?L, ?N)
long([],0).
long([_|L2], N) :- long(L2, N2), N is N2 + 1.

%partir(N,L,L1,L2) <- Pueden estar indefinidos L1 y L2. L tambien puede no estar instanciado pero solo si todos los demas lo estan.
partir(N,L,L1,L2) :- long(L1, N), append(L1,L2,L),!.

% borra X de L, borrar(+L, +X, -L2)
borrar([], _, []).
borrar([Y|L], X, L2) :- X = Y, borrar(L,X,L2), !.
borrar([Y|L], X, [Y|L2]) :-  X \= Y, borrar(L,X,L2), !.

%sacarDuplicados(+L1, -L2)
sacarDuplicados([],[]).
sacarDuplicados([X|L], L2) :- member(X,L), borrar(L,X,R), sacarDuplicados(R, L2),!.
sacarDuplicados([X|L], [Y|L2]) :- X = Y, sacarDuplicados(L,L2),!. 

%ocurrencias(+L1, +X, -N)
ocurrencias([],_,0).
ocurrencias([Y|L1], X, N) :- X = Y, ocurrencias(L1,X, N2),  N is N2 + 1,!.
ocurrencias([_|L1], X, N) :- ocurrencias(L1,X, N).

%permutacion(+L1, ?L2)
permutacion([],[]).
permutacion([X|L1], L2) :- ocurrencias(L1,X,N1), ocurrencias(L2,X,N2), N1 + 1 =:= N2, borrar(L1,X,R1), borrar(L2,X,R2), permutacion(R1,R2).

%superConcat(+L1,-L2)
superConcat([],[]).
superConcat([X|L1], L2) :- append(X, R, L2), superConcat(L1, R).

%todosSonSublistas(+LL, +L)
todosSonSublistas([],_).
todosSonSublistas([X|LL],L) :- sublista(X,L), todosSonSublistas(LL,L).

%reparto(+L, +N, -LL)

reparto(L, N, LL) :- long(LL,N), todosSonSublistas(LL,L), superConcat(LL,L). % long ya instancia a LL en [_,_,_,...] de longitud N. Un _ denota una variable anonima, es "any term".

reparto_sin_vacios(L,N,LL) :- reparto(L,N,R), borrar(R,[],LL).


%  [EJ 10]
desde(X,X).
desde(X,Y) :- N is X + 1, desde(N, Y).

% Para que el predicado funcione, X debe si o si estar instanciado. De no estarlo, va a tratar de calcular X + 1 

%desde2(+X, ?Y)

desde2(X,Y) :- var(Y), desde(X, Y).
desde2(X,Y) :- nonvar(Y), X =< Y.

% [EJ 11]
intercalar(L1,[],L1).
intercalar([],L2,L2).
intercalar([X|XS], [Y|YS], [X,Y|L]) :- intercalar(XS, YS, L).

% Reversibilidad: Un predicado define una relacion entre elementos, no hay parametros de entrada ni de salida. Conceptualmente, cualquier argumento podria cumplir ambos roles
%                 dependiendo de como se consulte. Un predicado pordria estar implementado asumiendo que ciertas variables ya estan instanciadas por cuestiones practicas. 

% Cuando piden explicar la reversibilidad, hay que decir si se puede obtener L3 a partir de LL1 y L2, y viceversa.

% En el caso de intercalar, se puede obtener L3 a partir de L1 y L2. Si L1 y L3 están instanciados entonces se puede conseguir L2 e idem L1. 

% [EJ 12] Asumir siempre que el árbol está instanciado

ab(nil).
ab(bin(izq,v,der)).

vacio(nil).

raiz(bin(_,R,_),N) :- N is R.

max(X,Y,X) :- Y < X,!.
max(_,Y,Y).


altura(nil, 0).
altura(ab(I, _, D), N) :- altura(I, N1), altura(D, N2), max(N1, N2, N3), N is N3 + 1.

cantidadDeNodos(nil,0).
cantidadDeNodos(ab(I,_,D),N) :- cantidadDeNodos(I, N1), cantidadDeNodos(D, N2), N is N1 + N2 + 1.

% [EJ 13]

%inorder(+AB,-Lista)
inorder(nil,[]).
inorder(bin(I,R,D),L) :- inorder(I, L1), inorder(D, L2), append(L1,[R|L2],L).

%arbolConInorder(+Lista,-AB)
arbolConInorder([], nil).
arbolConInorder([X], bin(nil,Y,nil)) :- X = Y.
arbolConInorder(L, bin(Iab,X,Dab)) :- append(I,[X|D],L), arbolConInorder(I,Iab), arbolConInorder(D,Dab).

%ABB(+T)

abb(nil).
abb(bin(nil,_,nil)).
abb(bin(nil,R,D)) :- abb(D), raiz(D,Rd), R < Rd.
abb(bin(I,R,nil)) :- abb(I), raiz(I,Ri), Ri < R.
abb(bin(I,R,D)) :-  abb(I), abb(D), raiz(I,Ri), raiz(D,Rd), Ri < R, R < Rd.

%   [SEGUNDA CLASE PRACTICA]

iesimo_2(0, [X|_], Y) :- X = Y.
iesimo_2(I, [_|L], Y) :- I > 0, I2 is I - 1, iesimo(I2, L, Y).
% Tengo que pedir que I > 0, porque no son disjuntas las clausulas
% Una vez que haga backtracking va a entrar a la segunda aunq I unifique con 0.

%esPar(+X)
esPar(0).
esPar(X) :- X > 0, Y is X - 2, esPar(Y).

%pmq(+X,-Y) instancia en Y todos los naturales menores o iguales a X.
pmq(X, Y) :- between(0,X,Y), esPar(Y).

%coprimos(-X,-Y) instancia todos los pares de numeros coprimos
coprimos(X,Y) :- desde(0,X), between(0,X,Y), G is gcd(X,Y), G =:= 1.



% prefijoI(+L, +I, -P) <- Predicado auxiliar para corteMasParejo
prefijo(_,0,[]).
prefijo([X|L], I, [X|P]) :- I \= 0, I2 is I - 1, prefijo(L,I2,P).

% sumatoria(+L, -N) <- Predicado auxiliar para corteMasParejo
sumatoria([],0).
sumatoria([X|L], N) :- sumatoria(L,N2), N is N2 + X.


%corteMasParejo(+L,-L1,-L2)
corteMasParejo(L, L1, L2) :- append(L1,L2,L), % append es reversible!
                             sumatoria(L1,N1),
                             sumatoria(L2,N2),
                             D is abs(N1 - N2), %Aca ya genere
                             not(hayCorteMejor(L,D)).

%hayCorteMejor(+L,+D)
hayCorteMejor(L,D) :- append(L1,L2,L),
                      sumatoria(L1,N1),
                      sumatoria(L2,N2),
                      D2 is abs(N1 - N2),
                      D2 < D.

%esTriangulo
esTriangulo(tri(A,B,C)) :- valido(A,B,C), valido(B,C,A), valido(A,C,B).
valido(A,B,C) :- A < B + C, abs(B - C) < A.

%perimetro(?T,?P) - uso ground pq se fija si estan semi instanciadas las variables del termino! ground tiene exito si ni A,B,C son libres, todas estas instanciadas
perimetro(tri(A,B,C), P) :- ground(tri(A,B,C)), esTriangulo(tri(A,B,C)), A + B + C =:= P. % <- sirve para P instanciado (devuelve t) y P no instanciado (lo instancia para que de t)
perimetro(tri(A,B,C), P) :- not(ground(tri(A,B,C))), 
                            desde2(3,P),
                            between(1,P,A),
                            P2 is P - A,
                            between(1,P2,B),
                            C is P2 - B,
                            esTriangulo(tri(A,B,C)). % Aca P puede estar o no instanciada. Si viene instanciada P, desde se cuelga asiq usamos desde2



%implementar un generador de triangulos validos
%triangulos(tri(A,B,C)) :- not(ground(tri(A,B,C))), desde(3,Y), perimetro(tri(A,B,C), Y).
triangulos(T) :- perimetro(T,_).

% [GUIA DE EJERCICIOS]

% [Generate & Test] <- es el ej 15 + el de los triangulos + el de los coprimos que ya tenes arriba
% [EJ 15]

% listaQueSuma(+S, -L) <- la inversa de sumatoria
listaQueSuma(0,[]).
listaQueSuma(S, [D|L]) :- between(1, S, D), I is S - D, listaQueSuma(I,L).

%semiLatino(+N,+M, +S, -Mat)

semiLatino(_,_,_,[]).
semiLatino(N,M,S,[F|Mat]) :- length([F|Mat], M), M2 is M - 1, listaQueSuma(S,F), length(F,N), semiLatino(N,M2,S,Mat).


%cuadradoSemiLatino(+N, -M).
cuadradoSemiLatino(N, M) :- desde(N,S),
                            semiLatino(N,N,S,M),
                            not(length(M,0)).

% [NEGACION POR FALLA Y CUT]

frutal(manzana).
frutal(frutilla).
frutal(banana).

cremoso(banana).
cremoso(americana).
cremoso(frutilla).
cremoso(dulceDeLeche).

leGusta(X) :- frutal(X), cremoso(X).
cucurucho(X,Y) :- leGusta(X),leGusta(Y).
                            
cremosoYdistinto(X,Y) :- cremoso(X), X \= Y.
% Si hacemos la consulta cucurucho(X,Y), va a instanciar a X en el primer sabor que sea frutal y cremoso, e idem con Y.
% Luego el output sera: X = Y, X = frutilla ; X = frutilla, Y = banana; X = banana, Y = frutilla; X = Y, Y = banana.

%maximo(+L,-N)
maximo([X],X).
maximo(L, N) :- length(L,Len), Len2 is Len - 1, between(0,Len2, I), iesimo(I,L,N), not(hayMayor(L,N)),!.

hayMayor([E|_],X) :- X < E, !.                                 
hayMayor([E|L],X) :- length(L,Len), Len > 0, E =< X, hayMayor(L,X). % solo evlauan true listas con long >= 2.

% [EJERCICIOS INTEGRADORES] :)

% [EJ 23]

% represento a los grafos como lista de adyacencia, e implemento esNodo y esArista para poder probar lo que hago <- grafo: [[0,0,0,0,0],[0,0,1,1,1],[0,1,0,0,0],[0,1,0,0,1],[0,1,0,1,0]]

unosYCeros([]).
unosYCeros([1|L]) :- unosYCeros(L).
unosYCeros([0|L]) :- unosYCeros(L).

esGrafo_Aux(_,[]).
esGrafo_Aux(N,[F|G]) :- unosYCeros(F), length(F,N), esGrafo_Aux(N,G).


esGrafo(G) :- length(G,N), esGrafo_Aux(N,G).

%esNodo(+G,?X)
esNodo(G,X) :- esGrafo(G), length(G,N), N2 is N - 1, between(0,N2,X).

%esArista(+G,?X,?Y).
esArista(G,X,Y) :- esGrafo(G), esNodo(G,X), esNodo(G,Y), iesimo(X,G,F), iesimo(Y,F,E), E =:= 1,!.


%vecino(+G, ?D, ?X). Reversible! iesimo tambien es reversible! iesimo(+L, ?I, -X)
vecino(G,D,X) :- esGrafo(G), esNodo(G,D), esNodo(G,X), esArista(G,D,X).

%caminoDesde(+G,?D,?I, -P,+U) <- Uso a U como "Used" para ir sabiendo que nodos ya use para no repetirlos.
caminoDesde_aux(G,D,0,[D],_) :- esGrafo(G).
caminoDesde_aux(G,D,I,[D,X|P],U) :- vecino(G,D,X), not(member(X,U)), caminoDesde_aux(G,X,I2,[X|P], [D|U]), I is I2 + 1, I > 0.

%caminoSimple(+G,+D,+H,?L).
caminoSimple(G,D,H,L) :- length(G,N), between(1,N,I), caminoDesde_aux(G,D,I,L,[]), sufijo([H],L).

%caminoHamiltoniano(+G,?L). <- es reversible porque caminoSimple lo es y aca estamos filtrando nomas
caminoHamiltoniano(G,L) :- esGrafo(G), caminoSimple(G,_,_,L), length(G,N), length(L,N). 
%hago generate and test, genero todos los caminos simples y solo uno de longitud N será hamiltoniano. 

noHayCamino(G,X,Y) :- not(caminoSimple(G,X,Y,_)).

%esConexo(G) :- not(noHayCamino(G,X,Y)).


% Predicados que hice y no use ---------------------------------------------------
todosDistintos([]).
todosDistintos([X|L]) :- not(member(X,L)), todosDistintos(L).

esCamino(G,[X]) :- esNodo(G,X).
esCamino(G,[X,Y|L]) :- esArista(G,X,Y), esCamino(G,[Y|L]). 

first([X|_],X).
%---------------------------------------------------------------------------------


% [ EJERCICIO DEL PARCIAL ]

%palabra(+A, +N, -P)

palabra(_,0,[]).
palabra(A, N, [X|P]) :- N \= 0, member(X, A), N2 is N - 1, palabra(A, N2, P). 
% No te olvides del N \=0! Si pedis ; va a backtrackear y entrar aca cuando N es 0 y va a hacer recursion con N negativos.

%frase(+A, -F) <- lista finita de palabras no vacias. Generar todas las frases posibles.

%frase(_,[]).
%frase(A, [X|F]) :- desde(1,I), palabra(A,I,X), frase(A,F). <- agrega la primer palabra infinitamente


%frase(A,F) :- desde(1,I), fraseDeIPalabras(A,I,F). <-- hace una frase con una sola palabra, como hay infinitas palabras haces infinitas frases de una palabra

fraseDeIPalabras(_,0,[]).
fraseDeIPalabras(A,I,[X|F]) :- I \= 0, desde(1,J), palabra(A, J, X), I2 is I - 1, fraseDeIPalabras(A, I2, F). 
%<- te hace la frase de I palabras, pero como hay infinitas palabras nunca para de generar la ultima palabra. El ultimo X lo instancia infinitamente


% Idea: haces una sola palabra y la particionas, cada particion es una palabra de tu frase. Asi tenes las infinitas frases posibles, con palabras finitas.

frase(A,F) :- desde(1,J), palabra(A,J,P), particionar(P,F).

%particionar(+P,-F).
particionar([],[]).
particionar(P,[X|F]) :- append(X,Su,P), length(X,N2), N2 \= 0, particionar(Su,F).

arbol(nil).
arbol(A) :- desde(1,J), arbolDeNNodos(A,J).

arbolDeNNodos(nil,0).
arbolDeNNodos(bin(AI,_,AD), N) :- N2 is N - 1, between(0,N2,J), arbolDeNNodos(AI,J), J2 is N2 - J, arbolDeNNodos(AD,J2).

nodosEn(nil,_).
nodosEn(bin(AI,V,AD), L) :- member(V,L), nodosEn(AI,L), nodosEn(AD,L).


%bin(nil,4,bin( bin(nil,pow,nil), pep , bin(nil, 8, nil)))

resta(L,[],L).
resta(L,[X|P],F) :- borrar(L,X,L2), resta(L2,P,F). 

subconjunto(L,P) :- length(L,N), between(0, N, I), subconjuntosN(L,I,P).

subconjuntosN(_,0,[]).
subconjuntosN(L,N,[X|S]) :- N \= 0, N2 is N - 1, member(X, L), borrar(L,X,R), subconjuntosN(R,N2,S).

particion(L, P, Q) :-  subconjunto(L,P), resta(L,P,Q).


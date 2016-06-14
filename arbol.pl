

/* PREDICADOS AUXILIARES */

append([],L,L). 
append([H|T],L2,[H|L3]) :- append(T,L2,L3).

noCreciente([_|[]]):-!. 
noCreciente([C|[C1|R1]]):- C >= C1, noCreciente([C1|R1]).

sumatoria([X|[]],X):-!.
sumatoria([X|XS],N):-sumatoria(XS,N2), N is N2 + X.

lenght([],0). 
lenght([_|L],T) :- lenght(L,T1), T is T1+1. 

noPertenece(_,[]):-!.
noPertenece(E,[X|L]) :- E\=X, noPertenece(E,L). 

noRepetidos([]).
noRepetidos([X|XS]):-noPertenece(X,XS), noRepetidos(XS).

maximoLista([X],X):-!. 
maximoLista([X|Xs],X):- maximoLista(Xs,Y), X >=Y. 
maximoLista([X|Xs],Y):- maximoLista(Xs,Y), Y > X.

bienEtiquetadoAuxiliar(nodo(A,[]),[],[A]):-!.
bienEtiquetadoAuxiliar(nodo(A,[arista(E,nodo(B,L))|XS]),[E|Aristas2],Nodos2):-
			E is A-B,
			bienEtiquetadoAuxiliar(nodo(B,L),Aristas,Nodos),
			bienEtiquetadoAuxiliar(nodo(A,XS),Aristas1,Nodos1),
			append(Aristas,Aristas1,Aristas2),
			append(Nodos,Nodos1,Nodos2).

/* PREDICADO BIEN ETIQUETADO */

bienEtiquetado(nodo(_,[])):-!.
bienEtiquetado(Arbol):-
			bienEtiquetadoAuxiliar(Arbol,Aristas,Nodos),
			noRepetidos(Aristas),
			noRepetidos(Nodos),
			maximoLista(Aristas,MaxDeAristas),
			lenght(Aristas,LongitudAristas),
			MaxDeAristas is LongitudAristas,
			maximoLista(Nodos,MaxDeNodos),
			lenght(Nodos,LongitudNodos),
			MaxDeNodos is LongitudNodos.



/* PREDICADO ESQUELETO */

hijos(_,_,[]).
hijos(N,R,[X|XS]):- R>=X,hijos(N,R,XS),!.

esqueleto(N,_,esq([X|[]])):- lenght(X,L),N is L,sumatoria(X,S), S is 0,!.
esqueleto(N,R,esq([X|[Y|ZS]])):-
			hijos(N,R,X),       
			noCreciente(Y),
			lenght(Y,L2),
			sumatoria(X,K),
			K is L2,
			lenght(X,L),
			N2 is N-L,
			esqueleto(N2,R,esq([Y|ZS])).


esqueleto2Auxiliar(1,_,[[0]]).
/*esqueleto2Auxiliar(N,R,Niveles):-*/


esqueleto2(N,R,esq(Niveles)):-esqueleto2Auxiliar(N,R,Niveles).

raiz(X,R,[[X]]):- generarNumeros(R,Ns), write(Ns),pertenece(X,Ns).

generarNumeros(0,[]):-!.
generarNumeros(N,[N|Xs]):- N2 is N-1,generarNumeros(N2,Xs).

pertenece(X,[X|_]):-!.
pertenece(X,[_|YS]):- pertenece(X,YS).




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
bienEtiquetadoAuxiliar(nodo(A,[arista(E,nodo(B,L))|XS]),[E|AristasAcum],NodosAcum):-
            E is abs(A-B),
            bienEtiquetadoAuxiliar(nodo(B,L),Aristas,Nodos),
            bienEtiquetadoAuxiliar(nodo(A,XS),Aristas1,Nodos1),
            append(Aristas,Aristas1,AristasAcum),
            append(Nodos,Nodos1,NodosAcum).

/* PREDICADO BIEN ETIQUETADO */

bienEtiquetado(nodo(1,[])):-!.
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

nivel(0,_,[]):-!.
nivel(N,R,[X|XS]):- between(0,R,X),N2 is N-1,nivel(N2,R,XS).

nivelNoCreciente(N,R,Nivel):- nivel(N,R,Nivel),noCreciente(Nivel).

esqueleto(1,_,esq([[0]|[]])):-!.
esqueleto(N,R,esq([[Raiz]|Niveles])):- between(1,R,Raiz),N2 is N-1,esqueletoAuxiliar(N2,R,[Raiz],Niveles).

esqueletoAuxiliar(0,_,Hijos,[]):-sumatoria(Hijos,Sum),Sum is 0,!.
esqueletoAuxiliar(N,R,Padres,[Hijos|X]):- 
			between(1,N,N2),
			nivelNoCreciente(N2,R,Hijos),
			lenght(Hijos,LongitudHijos),
			sumatoria(Padres,SumPadres),
			SumPadres is LongitudHijos,
			N3 is N-LongitudHijos,
			esqueletoAuxiliar(N3,R,Hijos,X).


/* PREDICADO ETIQUETAMIENTO */

etiquetamiento(esq([[0]|[]]),nodo(1,[])):-!.

,


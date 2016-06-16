

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

/* PREDICADO BIEN ETIQUETADO 
 * Esta predicado recibe un un funtor de tipo arbol, y nos dice si esta bien etiquetado 
 *
 * bienEtiquetado(+Arbol)
 * @param Arbol estructura de tipo Arbol
 */
bienEtiquetadoAuxiliar(nodo(A,[]),[],[A]):-!.
bienEtiquetadoAuxiliar(nodo(A,[arista(E,nodo(B,L))|XS]),[E|AristasAcum],NodosAcum):-
            E is abs(A-B),
            bienEtiquetadoAuxiliar(nodo(B,L),Aristas,Nodos),
            bienEtiquetadoAuxiliar(nodo(A,XS),Aristas1,Nodos1),
            append(Aristas,Aristas1,AristasAcum),
            append(Nodos,Nodos1,NodosAcum).

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


/* PREDICADO ESQUELETO 
 * 
 * esqueleto(+N,+R,-esqueleto)
 * @param N numero de nodos
 * @param R cantidad maxima de hijos para un cierto nodo
 * @param esqueleto estructura de tipo esqueleto     
 */


nivel(0,_,[]):-!.
nivel(N,R,[X|XS]):- between(0,R,X),N2 is N-1,nivel(N2,R,XS).

nivelNoCreciente(N,R,Nivel):- nivel(N,R,Nivel),noCreciente(Nivel).

esqueletoAuxiliar(0,_,Hijos,[]):-sumatoria(Hijos,Sum),Sum is 0,!.
esqueletoAuxiliar(N,R,Padres,[Hijos|X]):- 
                  between(1,N,N2),
                  nivelNoCreciente(N2,R,Hijos),
                  lenght(Hijos,LongitudHijos),
                  sumatoria(Padres,SumPadres),
                  SumPadres is LongitudHijos,
                  N3 is N-LongitudHijos,
                  esqueletoAuxiliar(N3,R,Hijos,X).

esqueleto(1,_,esq([[0]|[]])):-!.
esqueleto(N,R,esq([[Raiz]|Niveles])):- between(1,R,Raiz),N2 is N-1,esqueletoAuxiliar(N2,R,[Raiz],Niveles).

/* PREDICADO DESCRIBIR ETIQUETAMIENTO
 * describirEtiquetamiento(+Arbol)
 *
 * Predicado que dado una estructura de tipo arbol, muestra en pantalla 
 * @param Arbol estructura de tipo arbol
 */

describirEtiquetamiento(Arbol) :- describirEtiquetamiento(Arbol,[],0).
describirEtiquetamiento(nodo(A,[]),Padres,Arista):- append(Padres,[A],Padres2), print(Padres2), print(Arista).
describirEtiquetamiento(nodo(A,[arista(Arista,nodo(B,L))|XS]),Padres,Arista2):-
            append(Padres,[A],Padres2),
            describirEtiquetamiento(nodo(B,L),Padres2,Arista),
            describirEtiquetamiento(nodo(A,XS),Padres,Arista2). /* Exploramos el otro hijo, es necesario conocer el valor de la nueva arista*/

/* PREDICADO ETIQUETAMIENTO */

etiquetamiento(esq([[0]|[]]),nodo(1,[])):-!.

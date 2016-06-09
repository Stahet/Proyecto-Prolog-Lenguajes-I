bienEtiquetado(nodo(_,[])).
bienEtiquetado(nodo(A,[arista(E,nodo(B,L))|XS])):- E is A-B,!, bienEtiquetado(nodo(B,L)), bienEtiquetado(nodo(A,XS)),!.


/* Casos de prueba*/
bienEtiquetado(nodo(5),[]).
bienEtiquetado(nodo(4,[arista(1,nodo(2,[]))])). /**falla**/
bienEtiquetado(nodo(4,[
				arista(1,nodo(3,[])),
				arista(2,nodo(2,[])),
				arista(3,nodo(1,[]))
				])).

bienEtiquetado(nodo(8,[
				arista(1,nodo(7,[
					arista(4,nodo(3,[])),
					arista(2,nodo(5,[]))
					])),
				arista(2,nodo(7,[]))
				])).

bienEtiquetado(nodo(10,[
				arista(2,nodo(8,[
					arista(3,nodo(5,[
						arista(1,nodo(4,[]))
						]))
					]))
				])).

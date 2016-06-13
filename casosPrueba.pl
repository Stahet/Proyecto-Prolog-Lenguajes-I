/* Casos de prueba*/
bienEtiquetado(nodo(5,[]))./*Falla*/
 
bienEtiquetado(nodo(4,[arista(1,nodo(2,[]))]))./*falla*/

bienEtiquetadoAuxiliar(nodo(4,[arista(1,nodo(2,[]))]),A,N). /*falla*/

bienEtiquetado(nodo(4,[
                    arista(1,nodo(3,[])),
                    arista(2,nodo(2,[])),
                    arista(3,nodo(1,[]))
                ])).

bienEtiquetadoAuxiliar(nodo(4,[
                        arista(1,nodo(3,[])),
                        arista(2,nodo(2,[])),
                        arista(3,nodo(1,[]))
                        ]),A,N).

bienEtiquetado(nodo(8,[
                    arista(1,nodo(7,[
                                arista(4,nodo(3,[])),
                                arista(2,nodo(5,[]))
                                ])),
                    arista(2,nodo(7,[]))
                    ])).

bienEtiquetado(nodo(1,[
                    arista(1,nodo(2,[
                                arista(3,nodo(5,[])),
                                arista(2,nodo(4,[]))
                                ])),
                    arista(3,nodo(4,[]))
                    ])). /* Falla repeticion 3*/


bienEtiquetado(nodo(1,[
                    arista(2,nodo(3,[
                                arista(1,nodo(2,[]))
                                ])),
                    arista(3,nodo(4,[])),
                    arista(4,nodo(5,[]))
                    ])).

bienEtiquetado(nodo(0,[arista(1,nodo(1,[]))]))./*Falla*/

bienEtiquetadoAuxiliar(nodo(8,[
                            arista(1,nodo(7,[
                                        arista(4,nodo(3,[])),
                                        arista(2,nodo(5,[]))
                                        ])),
                            arista(2,nodo(7,[]))
                            ]),A,N).


bienEtiquetado(nodo(10,[
                    arista(2,nodo(8,[
                                arista(3,nodo(5,[
                                    arista(1,nodo(4,[]))
                                    ]))
                                ]))
                    ])).

bienEtiquetadoAuxiliar(nodo(10,[
                            arista(2,nodo(8,[
                                    arista(3,nodo(5,[
                                        arista(1,nodo(4,[]))
                                        ]))
                                    ]))
                            ]),A,N).
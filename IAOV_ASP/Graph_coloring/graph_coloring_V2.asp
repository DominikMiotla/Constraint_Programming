{color(N,C)}:- nodo(N), palette(C).

colorato(N) :- nodo(N), color(N,C).

:- nodo(N), not colorato(N).

:- near(X,Y), color(X,C), color(Y,C).

#show color/2.
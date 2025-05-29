color(N,red) :- nodo(N), not color(N,green), not color(N,yellow).
color(N,green) :- nodo(N), not color(N,red), not color(N,yellow).
color(N,yellow) :- nodo(N), not color(N,red), not color(N,green).

:- near(X,Y), color(X,C), color(Y,C). 

#show color/2.
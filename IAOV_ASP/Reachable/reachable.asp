reachable(1).
reachable(Y) :- reachable(X), edge(X,Y).

#show reachable/1.
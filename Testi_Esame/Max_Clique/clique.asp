{clique(N)}:- node(N).

edge(B,A) :- edge(A,B).

:- clique(A), clique(B), A != B, not edge(A,B).


#maximize{1,N:clique(N)}.
{clique(N)}:- node(N).

:- clique(N1), clique(N2), N1 != N2, not arc(N1,N2).

#maximize{1,N:clique(N)}.

#show clique/1.
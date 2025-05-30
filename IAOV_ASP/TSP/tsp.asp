1{arc(X,A):cost(X,A,C)}1:- node(A).

1{arc(A,Y):cost(A,Y,C)}1 :- node(A).

rechable(1).
rechable(Y) :- rechable(X), arc(X,Y).

:- node(Y), not rechable(Y).

#minimize{C,X,Y:arc(X,Y),cost(X,Y,C)}.

#show arc/2.
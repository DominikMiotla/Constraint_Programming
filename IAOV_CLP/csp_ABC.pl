:-lib(fd).

csp(A,B,C):-
    A :: 1..10,
    [B,C] :: 2..5,
    A #> B,
    B*C #< 11,
    A #\= C,
    labeling([B,C,A]).
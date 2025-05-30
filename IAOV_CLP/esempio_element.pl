:-lib(fd).

prodotti(X,Y):-
    X :: [1..5],
    Y :: [1..5],
    X #\= Y,
    element(X,[10,5,6,8,11],PrezzoX),
    element(Y,[10,5,6,8,11],PrezzoY),
    PrezzoX + PrezzoY #< 15,
    labeling([X,Y]).
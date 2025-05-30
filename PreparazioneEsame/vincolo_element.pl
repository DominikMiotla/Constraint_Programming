:-lib(fd).

spesa(X,Y):-
    [X,Y] :: [1..5],
    L = [10,5,6,8,11],

    X #\= Y,
    element(X,L,CostX),
    element(Y,L,CostY),
    CostX + CostY #< 15,
    labeling([X,Y]).
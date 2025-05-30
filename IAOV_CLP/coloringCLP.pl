:-lib(fd).

coloring([X1,X2,X3,X4,X5]):-
    X1 :: [red,green,blu,yellow],
    X2 :: [red,green,blu,yellow],
    X3 :: [red,green,blu,yellow],
    X4 :: [red,green,blu,yellow],
    X5 :: [red,green,blu,yellow],
    X2 #\= X1, X3 #\= X1,
    X4 #\= X1, X5 #\= X1,
    X3 #\= X2, X4 #\= X2,
    X5 #\= X2, X4 #\= X3,
    X4 #\= X5,
    labeling([X1,X2,X3,X4,X5]).
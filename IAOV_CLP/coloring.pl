coloring([X1,X2,X3,X4,X5]):-
    member(X1,[r,g,b,y]),
    member(X2,[r,g,b,y]),
    member(X3,[r,g,b,y]),
    member(X4,[r,g,b,y]),
    member(X5,[r,g,b,y]),
    X2 \= X1, X3 \= X1,
    X4 \= X1, X5 \= X1,
    X3 \= X2, X4 \= X2,
    X5 \= X2, X4 \= X3,
    X4 \= X5.
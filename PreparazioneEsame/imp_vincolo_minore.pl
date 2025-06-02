:-lib(fd).

minore(A,B):-
    dvar_domain(A,DomA),
    dom_range(DomA,MinA,MaxA),

    dvar_domain(B,DomB),
    dom_range(DomB,MinB,MaxB),

    SmalB is MinA + 1,
    GreA is MaxB - 1,

    dvar_remove_smaller(B, SmalB),
    dvar_remove_greater(A,GreA),

    (var(A), var(B)
        -> suspend(minore(A,B),3,[A->fd:min,B->fd:max])
        ; true
    ).
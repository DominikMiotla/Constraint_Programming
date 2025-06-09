:- [automobili2].
:- lib(fd).
:- lib(cumulative).


scheduling(ListC,ListA,ListN,End):-
    read_data(ListC,ListA,ListN,ListID,End,ListTask),
    impose_cumulative_linee(ListC,ListA,ListN,ListStartTime),
    impose_cumulative_task(ListID,ListTask),

    append(ListStartTime,[End],Vars),
    min_max(labeling(Vars),End).




impose_cumulative_task([],_).
impose_cumulative_task([ID|ListID],TaskList):-
    get_task_id(ID,TaskList,ListTaskID),
    generate_list_cumulative(ListTaskID,ListS,ListD,ListR),
    cumulative(ListS,ListD,ListR,1),
    impose_cumulative_task(ListID,TaskList).

get_task_id(_,[],[]).
get_task_id(ID,[rich(ID,EST,LCT,D,Start)|TaskList],[rich(ID,EST,LCT,D,Start)|ListTaskID]):-
    !, get_task_id(ID,TaskList,ListTaskID).
get_task_id(ID,[_|TaskList],ListTaskID):-
    get_task_id(ID,TaskList,ListTaskID).


impose_cumulative_linee(ListC,ListA,ListN,ListStartTime):-
    generate_list_cumulative(ListC,ListC_S,ListC_D,ListC_R),
    cumulative(ListC_S,ListC_D,ListC_R,1),
    generate_list_cumulative(ListA,ListA_S,ListA_D,ListA_R),
    cumulative(ListA_S,ListA_D,ListA_R,1),
    generate_list_cumulative(ListN,ListN_S,ListN_D,ListN_R),
    cumulative(ListN_S,ListN_D,ListN_R,1),
    append(ListC_S,ListA_S,Tmp1),
    append(Tmp1,ListN_S,ListStartTime).

generate_list_cumulative([],[],[],[]).
generate_list_cumulative([rich(_,_,_,D,Start)|TaskList],[Start|ListS],[D|ListD],[1|ListR]):-
    generate_list_cumulative(TaskList,ListS,ListD,ListR).


make_task_variables([],_,[]).
make_task_variables([rich(ID,EST,LCT,D)|DataList],End,[rich(ID,EST,LCT,D,Start)|TaskList]):-
    Start #>= EST,
    Start + D #<= LCT,
    Start + D #<= End,
    make_task_variables(DataList,End,TaskList).

read_data(ListC,ListA,ListN,ListID,End,ListTask):-
    findall(rich(ID,EST,LCT,20), rich(ID,EST,LCT,1,_,_), DataC),
    findall(rich(ID,EST,LCT,80), rich(ID,EST,LCT,_,1,_), DataA),
    findall(rich(ID,EST,LCT,50), rich(ID,EST,LCT,_,_,1), DataN),
    findall(ID,rich(ID,_,_,_,_,_),ListID),
    make_task_variables(DataC, End, ListC),
    make_task_variables(DataA, End, ListA),
    make_task_variables(DataN, End, ListN),
    append(ListC,ListA,Tmp1),
    append(Tmp1,ListN,ListTask).
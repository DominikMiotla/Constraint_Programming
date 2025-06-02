:-[data].
:-lib(fd).
:-lib(edge_finder).

schedule(Tasks,End):-
    findall(task(ID,D,Precs,M),task(ID,D,Precs,M),Data),
    makeTaskVariables(Data,Tasks,End),
    precedence(Tasks),

    generate_machine_list(ListM),
    impose_cumulative(ListM,Tasks),

    extract_start_time(Tasks,ListStart),
    append(ListStart,[End],Vars),
    min_max(labeling(Vars),End).

extract_start_time([],[]).
extract_start_time([task(_,_,_,_,Start)|Ts],[Start|Ls]):-
    extract_start_time(Ts,Ls).


impose_cumulative([],_).
impose_cumulative([M|ListM],Tasks):-
    find_task(M,Tasks,ListS,ListD,ListR),
    cumulative(ListS,ListD,ListR,1),
    impose_cumulative(ListM,Tasks).


find_task(_,[],[],[],[]):-!.
find_task(M,[task(_,D,_,M,Start)|Ts],[Start|ListS],[D|ListD],[1|ListR]):-
    !, find_task(M,Ts,ListS,ListD,ListR).
find_task(M,[_|Ts],ListS,ListD,ListR):-
    find_task(M,Ts,ListS,ListD,ListR).



precedence(Tasks) :- impose_precedence(Tasks,Tasks).

impose_precedence([],_).
impose_precedence([task(_,D,Precs,_,Start)|Ts],TasksList):-
    impose_after(Precs,Start,D,TasksList),
    impose_precedence(Ts,TasksList).

 impose_after([],_,_,_).
 impose_after([Taskj|Ps],Start,D,TasksList):-
    get_task(Taskj,TasksList,task(_,_,_,_,Startj)),
    Start + D #>= Startj,
    impose_after(Ps,Start,D,TasksList).

 get_task(Taskj,[task(Taskj,_,_,_,Startj)|Ts],task(Taskj,_,_,_,Startj)):-!.
 get_task(Taskj,[_|Ts],Task):-
    get_task(Taskj,Ts,Task).



makeTaskVariables([],[],_).
makeTaskVariables([task(ID,D,Precs,M)|Ds],[task(ID,D,Precs,M,Start)|Ts],End):-
    Start #>= 0,
    Start + D #<= End,
    makeTaskVariables(Ds,Ts,End).

generate_machine_list(ListM):-
    findall(M,task(_,_,_,M), DataM),
    remove_duplicate(DataM, ListM).


remove_duplicate([],[]):-!.
remove_duplicate([M|DataM],ListM):-
    member(M,DataM),!,remove_duplicate(DataM,ListM).
remove_duplicate([M|DataM],[M|ListM]):-
    remove_duplicate(DataM,ListM).


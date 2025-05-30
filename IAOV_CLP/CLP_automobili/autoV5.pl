:- [automobili].
:- lib(fd).
:- lib(edge_finder3).

csp(End,ListC,ListA,ListN):-
	findall(rich(ID,Deadline),(rich(ID,Deadline,C,A,N),C=1),DataC),
	findall(rich(ID,Deadline),(rich(ID,Deadline,C,A,N),A=1),DataA),
	findall(rich(ID,Deadline),(rich(ID,Deadline,C,A,N),N=1),DataN),
	
	makeRichVariables(DataC,End,20,ListC),
	makeRichVariables(DataA,End,80,ListA),
	makeRichVariables(DataN,End,50,ListN),

	impose_cumulative_m(ListC),
	impose_cumulative_m(ListA),
	impose_cumulative_m(ListN),
	
	extractStartTime(ListC,CSList),
	extractStartTime(ListA,CAList),
	extractStartTime(ListN,CNList),
	
	append(CSList,CAList,W),
	append(W,CNList,X),
	labeling(X).



makeRichVariables([],_,_,[]).
makeRichVariables([rich(ID,Deadline)|T],End,ProcTime,[rich(ID,Deadline,Start,ProcTime)|Var]):-
	Start #>= 0,
	Start + ProcTime #<= Deadline,
	Start + ProcTime #<= End,
	makeRichVariables(T,End,ProcTime,Var).

impose_cumulative_m(TaskList):-
	generate_lists(TaskList,StartList,DurList,ResList),
	cumulative(StartList,DurList,ResList,1).

generate_lists([],[],[],[]).
generate_lists([rich(_,_,Start,ProcTime)|T], [Start|Ss], [ProcTime|Ps], [1|Rs]):-
	generate_lists(T,Ss,Ps,Rs).

extractStartTime([],[]).
extractStartTime([rich(_,_,Start,_)|T],[Start|Ss]):-
	extractStartTime(T,Ss).

:- [automobili].
:- lib(fd).
:- lib(cumulative).

auto(End,ListRich, LC,LA,LS):-
	findall(rich(ID,Deadline,C,A,S),rich(ID,Deadline,C,A,S),Data),
	makeRichVariables(Data,End,ListRich),
	select_rich_c(ListRich,LC,_,_),
	select_rich_a(ListRich,LA,_,_),
	select_rich_s(ListRich,LS,_,_).

makeRichVariables([],_,[]).
makeRichVariables([rich(ID,Deadline,C,A,S)|D],End,[rich(ID,Deadline,C,A,S,Start)|Var]):-
	Start #>= 0,
	Start + (C*20) + (A*80) + (S*50) #<= Deadline,
	Start + (C*20) + (A*80) + (S*50) #<= End,
	makeRichVariables(D,End,Var).






select_rich_c([],[],[],[]).
select_rich_c([rich(ID,_,1,_,_,Start)|T], [[ID,Start]|LStart], [20|LDur], [1|LRes]):-
	!, select_rich_c(T,LStart,LDur,LRes).
select_rich_c([_|T], LStart, LDur, LRes):-
	select_rich_c(T,LStart,LDur,LRes).

select_rich_a([],[],[],[]).
select_rich_a([rich(ID,_,_,1,_,Start)|T], [[ID,Start]|LStart], [80|LDur], [1|LRes]):-
	!, select_rich_a(T,LStart,LDur,LRes).
select_rich_a([_|T], LStart, LDur, LRes):-
	select_rich_a(T,LStart,LDur,LRes).

select_rich_s([],[],[],[]).
select_rich_s([rich(ID,_,_,_,1,Start)|T], [[ID,Start]|LStart], [80|LDur], [1|LRes]):-
	!, select_rich_s(T,LStart,LDur,LRes).
select_rich_s([_|T], LStart, LDur, LRes):-
	select_rich_s(T,LStart,LDur,LRes).

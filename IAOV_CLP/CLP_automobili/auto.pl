:- [automobili].
:- lib(fd).
:- lib(cumulative).

linea(1). %cerchi
linea(2). %aria
linea(3). %navigatore

auto(End,ListRich,Ls):-
	findall(rich(ID,Deadline,C,A,S),rich(ID,Deadline,C,A,S),Data),
	makeRichVariables(Data,End,ListRich),
	findall(X,linea(X),Ls),
	impose_cumulative_m(Ls,ListRich).

makeRichVariables([],_,[]).
makeRichVariables([rich(ID,Deadline,C,A,S)|D],End,[rich(ID,Deadline,C,A,S,Start)|Var]):-
	Start #>= 0,
	Start + (C*20) + (A*80) + (S*50) #<= Deadline,
	Start + (C*20) + (A*80) + (S*50) #<= End,
	makeRichVariables(D,End,Var).

impose_cumulative_m([],_).
impose_cumulative_m([L|T],ListRich):-
	select_rich(Linea,ListRich, StartList, DurList, ResList),
	cumulative(StartList,DurList,ResList,1),
	impose_cumulative_m(T,ListRich).


select_rich(_,[],[],[],[]).
select_rich(Linea,[R|T], [Start|LStart], [Dur|LDur], [1|LRes]):-
	sel_rich(Linea,R,Start,Dur),!,
	select_rich(Linea,T,LStart,LDur,LRes).
select_rich(Linea,[_|T], LStart, LDur, LRes):-
	select_rich(Linea,T,LStart,LDur,LRes).

sel_rich(1,rich(ID,_,1,_,_,Start),Start,20):-!.
sel_rich(2,rich(ID,_,_,1,_,Start),Start,80):-!.
sel_rich(3,rich(ID,_,_,_,1,Start),Start,50).

:-lib(fd).
:-lib(fd_global).
:-lib(edge_finder).

colf(StartTimeTask,EndTime):-
    StartTimeTask = [Lavatrice, Asciugatrice, Stirare, Lavastoviglie, Impastare, Lievitazione,Preiscaldamento,Cottura,Pulizia],
    StartTimeTask :: [0..200],

    DurataLievitazione :: [60..120],
    Durations = [45,60,60,40,15,DurataLievitazione,5,15,120],

    Resources = [1700,1000,2000,1800,0,0,2000,2000,0],
    MAX_Resources = 3000,

    Colf = [0,0,1,0,1,0,0,0,1],
    MAX_Colf = 1,

    cumulative(StartTimeTask,Durations,Resources,MAX_Resources),
    cumulative(StartTimeTask,Durations,Colf,MAX_Colf),

    Asciugatrice #> Lavatrice + 45,
    Stirare #> Asciugatrice + 60,

    Lievitazione #> Impastare + 15,
    Preiscaldamento + 5 #= Lievitazione + DurataLievitazione,
    Cottura #> Preiscaldamento + 5,

    endtime(StartTimeTask,Durations,EndTimeList),
    maxlist(EndTimeList,EndTime),
    EndTime #<= 200,
    
    append(StartTimeTask,[DurataLievitazione,EndTime],Vars),
    min_max(labeling(Vars),EndTime).



endtime([],[],[]).
endtime([S|Ls],[D|Ld],[E|Le]):-
    E #= S + D,
    endtime(Ls,Ld,Le).




combine1([],[],[]).
combine1([X1|R1],[X2|R2],[X1,X2 | R3]) :- combine1(R1,R2,R3).

combine2([],[],[]).
combine2([X1|R1],[X2|R2],[[X1,X2] | R3]) :- combine2(R1,R2,R3).

combine3([],[],[]).
combine3([X1|R1],[X2|R2],[j(X1,X2) | R3]) :- combine3(R1,R2,R3).


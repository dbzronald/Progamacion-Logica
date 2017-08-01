accMin([],A,A).

accMin([H|T],A,Min) :-
    H < A,
    accMin(T,H,Min).

accMin([H|T],A,Min) :-
    H >= A,
    accMin(T,A,Min).

min(List, Min) :-
  List = [H|_],
  accMin(List, H, Min).

scalarMult(A, [], []).

scalarMult(A, [H1|T1], [H2|T2]) :-
  is(H2,*(H1,A)),
  scalarMult(A, T1, T2).

accDot([],[],A,A).

accDot([H1|T1], [H2|T2], A, Result) :-
  is(Anew,+(A,*(H1,H2))),
  accDot(T1, T2, Anew, Result).

dot(Vector1, Vector2, Result) :-
  accDot(Vector1, Vector2, 0, Result).

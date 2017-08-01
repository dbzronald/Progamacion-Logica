% replace(+List,+Index,+Value,-NewList).
replace([_|T], 1, X, [X|T]).
replace([H|T], I, X, [H|R]) :-
  I > 0,
  NI is I-1,
  replace(T, NI, X, R),
  !.
replace(L, _, _, L).

% left
dir(Index,Board,Move) :-
  member(Index,[2,3,5,6,8,9]),
  Swap is Index - 1,
  nth1(Swap,Board,Elem),
  replace(Board,Index,Elem,Tmp),
  replace(Tmp,Swap,0,Move).
% right
dir(Index,Board,Move) :-
  member(Index,[1,2,4,5,7,8]),
  Swap is Index + 1,
  nth1(Swap,Board,Elem),
  replace(Board,Index,Elem,Tmp),
  replace(Tmp,Swap,0,Move).
% up
dir(Index,Board,Move) :-
  member(Index,[4,5,6,7,8,9]),
  Swap is Index - 3,
  nth1(Swap,Board,Elem),
  replace(Board,Index,Elem,Tmp),
  replace(Tmp,Swap,0,Move).
% down
dir(Index,Board,Move) :-
  member(Index,[1,2,3,4,5,6]),
  Swap is Index + 3,
  nth1(Swap,Board,Elem),
  replace(Board,Index,Elem,Tmp),
  replace(Tmp,Swap,0,Move).
move(Board,Move) :-
  nth1(Index,Board,0),
  dir(Index,Board,Move).

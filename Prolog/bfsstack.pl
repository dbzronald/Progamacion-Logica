%(SWI-Prolog)You can run the program by: ?- Bestfs([8,1,3,7,0,2,6,5,4],P).

initial([8,1,3,7,0,2,6,5,4]).

goal([1,2,3,8,0,4,7,6,5]).

operators([left, right, up, down]).

% 8-puzzle solution
% initial([8,1,3,7,0,2,6,5,4]).
% goal([1,2,3,8,0,4,7,6,5]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Best-first Search %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bestfs(Start,Path):-
heuristic(Start, Distance),
bestfs_path([ node(Start, Distance, []) ], Path).
bestfs_path([node(Goal, _, Path)| _], Path):-
goal(Goal).
bestfs_path([node(Current, _, Path) | Queue],
GoalPath) :-
findall(node(Child, Distance, PathToChild),
(
  apply(Operator, Current, Child),
  heuristic(Child, Distance),
  append(Path, [Operator], PathToChild)
 ), ChildNodes),
add_to_list(ChildNodes, Queue, NewQueue),
bestfs_path(NewQueue, GoalPath).

% add_to_list adds a new list into an old (ordered) list
% by recursively adding members of the new list at their
% appropriate position in the old list. The returned list
% is also ordered.

add_to_list([], L, L).
add_to_list([H|T], OldList, NewList):-
insert_at_place(H, OldList, TempList),
add_to_list(T, TempList, NewList).

% insert_at_place simply adds a new element at the right
% place of an ordered list so as to return another
% ordered list (provisions have been made for the node
% datastructure that is used in out implementation of
% best-first search)
insert_at_place(X, [], [X]).
insert_at_place(node(NodeX, X, PathX),
        [node(NodeY, Y, PathY) | L],
             [node(NodeX, X, PathX),
           node(NodeY, Y, PathY) | L]) :-
X =< Y.

insert_at_place(node(NodeX, X, PathX),
                [node(Node, Y, PathY) | L],
                [node(Node, Y, PathY) | NewL]) :-
X > Y,
insert_at_place(node(NodeX, X, PathX), L, NewL).
 % Of course, we need to choose our heuristic
% change this to use any other heuristic, such as
% manhattan distance
heuristic(X, Y) :-
displaced(X, Y).
% manhattan(X,Y).

%=====================================================================

%Implementation of 8-Puzzle Operators

%====================================================================

% move_left in the top row
move_left([X1,0,X3, X4,X5,X6, X7,X8,X9], [0,X1,X3, X4,X5,X6, X7,X8,X9]).
move_left([X1,X2,0, X4,X5,X6, X7,X8,X9], [X1,0,X2, X4,X5,X6, X7,X8,X9]).

% move_left in the middle row
move_left([X1,X2,X3, X4,0,X6, X7,X8,X9], [X1,X2,X3, 0,X4,X6, X7,X8,X9]).
move_left([X1,X2,X3, X4,X5,0, X7,X8,X9], [X1,X2,X3, X4,0,X5, X7,X8,X9]).

% move_left in the bottom row
move_left([X1,X2,X3, X4,X5,X6, X7,0,X9], [X1,X2,X3, X4,X5,X6, 0,X7,X9]).
move_left([X1,X2,X3, X4,X5,X6, X7,X8,0], [X1,X2,X3, X4,X5,X6, X7,0,X8]).

% move_right in the top row
move_right([0,X2,X3, X4,X5,X6, X7,X8,X9], [X2,0,X3, X4,X5,X6, X7,X8,X9]).
move_right([X1,0,X3, X4,X5,X6, X7,X8,X9], [X1,X3,0, X4,X5,X6, X7,X8,X9]).

% move_right in the middle row
move_right([X1,X2,X3, 0,X5,X6, X7,X8,X9], [X1,X2,X3, X5,0,X6, X7,X8,X9]).
move_right([X1,X2,X3, X4,0,X6, X7,X8,X9], [X1,X2,X3, X4,X6,0, X7,X8,X9]).

% move_right in the bottom row
move_right([X1,X2,X3, X4,X5,X6, 0,X8,X9], [X1,X2,X3, X4,X5,X6, X8,0,X9]).
move_right([X1,X2,X3, X4,X5,X6, X7,0,X9], [X1,X2,X3, X4,X5,X6, X7,X9,0]).

% move_up from the middle row
move_up([X1,X2,X3, 0,X5,X6, X7,X8,X9], [0,X2,X3, X1,X5,X6, X7,X8,X9]).
move_up([X1,X2,X3, X4,0,X6, X7,X8,X9], [X1,0,X3, X4,X2,X6, X7,X8,X9]).
move_up([X1,X2,X3, X4,X5,0, X7,X8,X9], [X1,X2,0, X4,X5,X3, X7,X8,X9]).

% move_up from the bottom row
move_up([X1,X2,X3, X4,X5,X6, 0,X8,X9], [X1,X2,X3, 0,X5,X6, X4,X8,X9]).
move_up([X1,X2,X3, X4,X5,X6, X7,0,X9], [X1,X2,X3, X4,0,X6, X7,X5,X9]).
move_up([X1,X2,X3, X4,X5,X6, X7,X8,0], [X1,X2,X3, X4,X5,0, X7,X8,X6]).

% move_down from the top row
move_down([0,X2,X3, X4,X5,X6, X7,X8,X9], [X4,X2,X3, 0,X5,X6, X7,X8,X9]).
move_down([X1,0,X3, X4,X5,X6, X7,X8,X9], [X1,X5,X3, X4,0,X6, X7,X8,X9]).
move_down([X1,X2,0, X4,X5,X6, X7,X8,X9], [X1,X2,X6, X4,X5,0, X7,X8,X9]).

% move_down from the middle row
move_down([X1,X2,X3, 0,X5,X6, X7,X8,X9], [X1,X2,X3, X7,X5,X6, 0,X8,X9]).
move_down([X1,X2,X3, X4,0,X6, X7,X8,X9], [X1,X2,X3, X4,X8,X6, X7,0,X9]).
move_down([X1,X2,X3, X4,X5,0, X7,X8,X9], [X1,X2,X3, X4,X5,X9, X7,X8,0]).

% Applying an operator
apply(left,S1,S2)  :- move_left(S1,S2).
apply(right,S1,S2) :- move_right(S1,S2).
apply(up,S1,S2)    :- move_up(S1,S2).
apply(down,S1,S2)  :- move_down(S1,S2).

%======================================================================

%Implementation of 8-Puzzle Heuristic Functions

%======================================================================


% displacement heuristic

displaced(State, Number) :-
  goal(Goal),
  misplaced(State,Goal,Number).

% misplaced returns the number of tiles found in the wrong position

misplaced([],[],0).
misplaced([0|T1],[0|T2],Number) :- !,
  misplaced(T1,T2,Number).
misplaced([H|T1],[H|T2],Number) :- !,
  misplaced(T1,T2,Number).
misplaced([H1|T1],[H2|T2],Number) :- !,
  H1\==H2,
  misplaced(T1,T2,N),
  Number is N+1.


% Manhattan Distance heuristic

manhattan(State, Number) :-
  manh(State,State,0,Number).

manh([], _, X, X).

manh([H|T], State, Acc, Result) :-
  nth1(Position, State, H),
  NewPos is Position - 1,
  Xaux1 is NewPos mod 3,
  X1 is integer(Xaux1),
  Y1 is NewPos // 3,
  goal(Goal),
  nth1(GoalPosition, Goal, H),
  NewGPos is GoalPosition - 1,
  Xaux2 is NewGPos mod 3,
  X2 is integer(Xaux2),
  Y2 is NewGPos // 3,
  S1 is abs(X1-X2),
  S2 is abs(Y1-Y2),
  N is S1+S2,
  NewAcc is Acc+N,
  manh(T, State, NewAcc, Result).

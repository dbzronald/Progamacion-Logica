%$Id: eight.pl,v 1.2 2009/05/24 20:31:45 mbar098 Exp mbar098 $


:- use_module(library(lists)). % for p

stateToPuzzle(State, Puzzle) :-
	stateToPuzzle(State, [ ], Puzzle).
stateToPuzzle(_, Puzzle, Puzzle) :-
	      length(Puzzle, 9).
stateToPuzzle(State, PartialPuzzle, FullPuzzle) :-
	length(PartialPuzzle, Length),
	Length < 9,
	NewTile is State mod 10,
	StateRemainder is State // 10,
	stateToPuzzle(StateRemainder,
		      [NewTile | PartialPuzzle],
		      FullPuzzle).

puzzleToState(Puzzle, State) :-
	puzzleToState(Puzzle, 0, State).

puzzleToState([ ], State, State).
puzzleToState([Location | Rest], PartialState, FullState) :-
	NewPartialState is PartialState * 10 + Location,
	puzzleToState(Rest, NewPartialState, FullState).

adjacent(0,1).
adjacent(0,3).
adjacent(1,0).
adjacent(1,2).
adjacent(1,4).
adjacent(2,1).
adjacent(2,5).
adjacent(3,0).
adjacent(3,4).
adjacent(3,6).
adjacent(4,1).
adjacent(4,3).
adjacent(4,5).
adjacent(4,7).
adjacent(5,2).
adjacent(5,4).
adjacent(5,8).
adjacent(6,3).
adjacent(6,7).
adjacent(7,4).
adjacent(7,6).
adjacent(7,8).
adjacent(8,5).
adjacent(8,7).


/* neighbor(+State, -NeighborState)

blank's location and a Tile's location are adjacent and they have been*/
/* reversed

*/
neighbor(State, Neighbor) :-
	stateToPuzzle(State, Puzzle),
	tileNextToBlank(Puzzle, Tile),
	swapWithBlank(Puzzle, Tile, NewPuzzle),
	puzzleToState(NewPuzzle, Neighbor).

cost(_, _, 1).

neighbours(State, Neighbours) :-
	findall(Neighbor, neighbor(State, Neighbor), Neighbours).

tileNextToBlank([BlankLoc | Rest], Tile) :-
	adjacent(BlankLoc, TileLoc),
	nth0(Tile, [BlankLoc | Rest], TileLoc).

swapWithBlank([BlankLoc | Rest], Tile, NewPuzzle) :-
	nth1(Tile, Rest, TileLoc),
	Length1 is Tile - 1,
	append_length(Part1, [_ | Part2], Rest, Length1),
	append([TileLoc | Part1], [BlankLoc | Part2], NewPuzzle).

%============================================================

is_goal(801234567).
%801234567
%============================================================
showPath([ ]).
showPath([State | Rest]) :-
	showState(State),
	nl,
	showPath(Rest).

showState(State) :-
	stateToPuzzle(State, Puzzle),
	invertPuzzleRep(Puzzle, InvertedPuzzleRep),
	showRow(InvertedPuzzleRep, 0),
	nl,
	showRow(InvertedPuzzleRep, 3),
	nl,
	showRow(InvertedPuzzleRep, 6),
	nl.

invertPuzzleRep(Puzzle, InvertedPuzzle) :-
	length(Puzzle, 9),
	length(InvertedPuzzle, 9),
	inverseReps(8, Puzzle, InvertedPuzzle).

inverseReps(-1, _, _).
inverseReps(Position, Puzzle, InvertedPuzzle) :-
	nth0(Position, Puzzle, Element),
	nth0(Element, InvertedPuzzle, Position),
	NextPosition is Position - 1,
	inverseReps(NextPosition, Puzzle, InvertedPuzzle).

showRow(InvertedPuzzle, Index) :-
	nth0(Index, InvertedPuzzle, Tile),
	showTile(Tile),
	NextIndex is Index + 1,
	nth0(NextIndex, InvertedPuzzle, NextTile),
	showTile(NextTile),
	LastIndex is NextIndex + 1,
	nth0(LastIndex, InvertedPuzzle, LastTile),
	showTile(LastTile).

showTile(0) :-
	write('  ').
showTile(Tile) :-
	Tile > 0,
	write(Tile), write(' ').

/*  File:    8-puzzle.pl
    Author:  Carlo,,,
    Created: Feb  4 2013
    Purpose: solve 8-puzzle
*/

:- module(eight_puzzle,
      [eight_puzzle/3
      ]).

:- use_module(library(nb_set)).

% test cases from Stack Overflow thread with Joel76
test0(R) :- eight_puzzle([1,2,3,4,5,6,7,8,0], [1,0,3, 5,2,6, 4,7,8], R).
test1(R) :- eight_puzzle([1,2,3,4,5,6,7,8,0], [8,7,4, 6,0,5, 3,2,1], R).

%  eight_puzzle(+Target, +Start, -Moves) is ndet
%
%   public interface to solver
%
eight_puzzle(Target, Start, Moves) :-
    empty_nb_set(E),
    eight_p(E, Target, Start, Moves).

%%  -- private here --

eight_p(_, Target, Target, []) :-
    !.
eight_p(S, Target, Current, [Move|Ms]) :-
    add_to_seen(S, Current),
    setof(Dist-M-Update,
          (  get_move(Current, P, M),
         apply_move(Current, P, M, Update),
         distance(Target, Update, Dist)
          ), Moves),
    member(_-Move-U, Moves),
    eight_p(S, Target, U, Ms).

%%  get_move(+Board, +P, -Q) is semidet
%
%   based only on coords, get next empty cell
%
get_move(Board, P, Q) :-
    nth0(P, Board, 0),
    coord(P, R, C),
    (   R < 2, Q is P + 3
    ;   R > 0, Q is P - 3
    ;   C < 2, Q is P + 1
    ;   C > 0, Q is P - 1
    ).

%%  apply_move(+Current, +P, +M, -Update)
%
%   swap elements at position P and M
%
apply_move(Current, P, M, Update) :-
    assertion(nth0(P, Current, 0)), % constrain to this application usage
    ( P > M -> (F,S) = (M,P) ; (F,S) = (P,M) ),
    nth0(S, Current, Sv, A),
    nth0(F, A, Fv, B),
    nth0(F, C, Sv, B),
    nth0(S, Update, Fv, C).

%%  coord(+P, -R, -C)
%
%   from linear index to row, col
%   size fixed to 3*3
%
coord(P, R, C) :-
    R is P // 3,
    C is P mod 3.

%%  distance(+Current, +Target, -Dist)
%
%   compute Manatthan distance between equals values
%
distance(Current, Target, Dist) :-
    aggregate_all(sum(D),
              (   nth0(P, Current, N), coord(P, Rp, Cp),
              nth0(Q, Target, N), coord(Q, Rq, Cq),
              D is abs(Rp - Rq) + abs(Cp - Cq)
              ), Dist).

%%  add_to_seen(+S, +Current)
%
%   fail if already in, else store
%
add_to_seen(S, [A,B,C,D,E,F,G,H,I]) :-
    Sig is
    A*100000000+
    B*10000000+
    C*1000000+
    D*100000+
    E*10000+
    F*1000+
    G*100+
    H*10+
    I,
    add_nb_set(Sig, S, true).

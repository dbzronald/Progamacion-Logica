miembro(X, [X|_]).
miembro(X, [_|Z]) :- miembro(X,Z).

concatenar([], L, L).
concatenar([X|Y], Z, [X|U]) :- concatenar(Y, Z, U).

ultimo([X|[]], X).
ultimo([_|Z], X) :- ultimo(Z, X).

inversa(X, Y):- inversa(X, Y, []).
inversa([X|Z], Y, T):- inversa(Z, Y, [X|T]).
inversa([], T, T).

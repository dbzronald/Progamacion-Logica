fact(0, 1).
fact(N, Y):- M is N-1, fact(M, Z), Y is N*Z.

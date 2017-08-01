fact(X, Y):- fact-aux(X, 1, Y).
fact-aux(0, Y, Y).
fact-aux(N, Y, Z):- U is N*Y, M is N-1, fact-aux(M, U, Z).

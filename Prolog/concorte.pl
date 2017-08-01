nota(95,a).
nota(85,b).
nota(75,c).
nota(65,d).
nota(55,f).

nota(X,f) :- X<60,!.
nota(X,d) :- X<70,!.
nota(X,c) :- X<80,!.
nota(X,b) :- X<90,!.
nota(X,a).



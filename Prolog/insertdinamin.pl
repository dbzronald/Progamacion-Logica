:-  dynamic  dato/3.

suma_cuadrado(X,Y,Res):-
         dato(X,Y,Res),  !.

suma_cuadrado(X,Y,Res):-
         Res  is  (X+Y)*(X+Y),
         assert(dato(X,Y,Res)).



%ejercicios 11.2
   q(blob,blug).
   q(blob,blag).
   q(blob,blig).
   q(blaf,blag).
   q(dang,dong).
   q(dang,blug).
   q(flab,blob).

%sigma
:-dynamic dato/2.
sigma(X,Y):- dato(X,Y),!.
sigma(0,0):- !.
sigma(X, R):- X>0,M is X-1, sigma(M, R2),R is R2+X, assert(dato(X,R)).


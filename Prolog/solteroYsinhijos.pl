hombre(juan).
hombre(carlos).
mujer(maria).
mujer(laura).
padre(juan,maria).
padre(juan,carlos).
madre(laura,maria).
madre(laura,carlos).
esposo(juan,laura).
esposo(laura,juan).

solteroYsinhijos(X) :- hombre(X),not(esposo(X,_)).


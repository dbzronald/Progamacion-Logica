ganados(juan,7).
ganados(susana,6).
ganados(pedro,2).
ganados(rosa,5).
jugados(rosa,10).
jugados(juan,13).
jugados(pedro,3).
jugados(susana,7).

porcentaje(X,P) :- ganados(X,G), jugados(X,J), P is round(G/J*100),write('Porcentaje de juegos ganados  '),write(P),write('%').

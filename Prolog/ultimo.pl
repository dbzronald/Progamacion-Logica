ultimo(X, [X]).
ultimo(X, [Y|Z]) :- ultimo(X,Z).

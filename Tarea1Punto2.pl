es_estadounidense(west).
es_nacion(corea_sur).
es_enemigo(corea_sur, eeuu).
es_misil(m1).
pertenece(m1, corea_sur).       % corea del Sur tiene el misil m1
vendio(west, m1, corea_sur).    % West le vendió el misil a Corea del Sur

% Reglas
es_arma(X) :- es_misil(X).
es_hostil(X) :- es_enemigo(X, eeuu), es_nacion(X).

es_criminal(X):- es_estadounidense(X), vendio(X, Arma, Nacion), es_arma(Arma), es_hostil(Nacion).

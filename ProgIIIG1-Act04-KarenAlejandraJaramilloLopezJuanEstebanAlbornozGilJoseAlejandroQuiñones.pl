progenitor(clara, jose).
progenitor(tomas, jose).
progenitor(tomas, isabel).
progenitor(jose, ana).
progenitor(jose, patricia).
progenitor(patricia, jaime).

%hombres
hombre(jose).
hombre(tomas).
hombre(jaime).
%mujeres 
mujer(clara).
mujer(isabel).  
mujer(ana).
mujer(patricia).

%reglas
diferente(X, Y) :- X\=Y.

es_madre(X):- mujer(X), progenitor(X,_).
es_padre(X):- hombre(X), progenitor(X,_).
es_hijo(X):- hombre(X), progenitor(_,X).
hermana_de(X,Y):- mujer(X), progenitor(Z,X),progenitor(Z,Y),diferente(X,Y).
abuelo_de(X,Y):- hombre(X),progenitor(X,Z),progenitor(Z,Y).
abuela_de(X,Y):- mujer(X),progenitor(X,Z),progenitor(Z,Y).
hermanos(X,Y):- progenitor(Z,X),progenitor(Z,Y),diferente(X,Y).
tia(X,Y):- mujer(X),progenitor(Z,Y),hermanos(X,Z).




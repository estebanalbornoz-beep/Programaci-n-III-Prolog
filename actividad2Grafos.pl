conexion_de(vancouver, edmonton, 16).
conexion_de(vancouver,calgary, 13).
conexion_de(edmonton,saskatoon, 12).
conexion_de(calgary,edmonton, 4).
conexion_de(calgary,regina, 14).
conexion_de(saskatoon,calgary,9).
conexion_de(saskatoon,winnipeg, 20).
conexion_de(regina,saskatoon, 7).
conexion_de(regina,winnipeg, 4).



% Reglas

tiene_aristas(Nodo) :-
    conexion_de(Nodo, _, _);
    conexion_de(_, Nodo, _).

tiene_conexiones(Origen) :-
    conexion_de(Origen, _, _).

costo_nodos(X, Y, Z, CostoTotal) :-
    conexion_de(X, Y, Costo1),
    conexion_de(Y, Z, Costo2),
    CostoTotal is Costo1 + Costo2.

tiene_conexion(X, Y) :-
    conexion_de(X, Y, _).
tiene_conexion(X, Y) :-
    conexion_de(X, Z, _),
    tiene_conexion(Z, Y).
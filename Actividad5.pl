% --- Hechos ---
papa_de(hombre(abraham), [hombre(homero), hombre(herbert)]).
papa_de(hombre(clancy), [mujer(marge), mujer(patty), mujer(selma)]).
papa_de(hombre(homero), [mujer(lisa), hombre(bart), mujer(maggie)]).
mama_de(mujer(mona), [hombre(homero)]).
mama_de(mujer(jacqueline), [mujer(marge), mujer(patty), mujer(selma)]).
mama_de(mujer(marge), [hombre(bart), mujer(lisa), mujer(maggie)]).
mama_de(mujer(selma), [mujer(ling)]).


%Reglas
abuelo_de(Abuelo, Nieto) :-
    papa_de(hombre(Abuelo), Hijos),
    member(Hijo, Hijos),
    (papa_de(Hijo, Nietos); mama_de(Hijo, Nietos)),
    (member(hombre(Nieto), Nietos); member(mujer(Nieto), Nietos)).

abuela_de(Abuela, Nieto) :-
    mama_de(mujer(Abuela), Hijos),
    member(Hijo, Hijos),
    (papa_de(Hijo, Nietos); mama_de(Hijo, Nietos)),
    (member(hombre(Nieto), Nietos); member(mujer(Nieto), Nietos)).

hermano_de(Hermano, Persona) :-
    papa_de(_, Hijos), member(hombre(Hermano), Hijos), member(_, Hijos), Hermano \= Persona,
    (mama_de(_, HijosM), member(HermanoStruct, HijosM), member(PersonaStruct, HijosM),
     (HermanoStruct = hombre(Hermano); HermanoStruct = mujer(Hermano)),
     (PersonaStruct = hombre(Persona); PersonaStruct = mujer(Persona))).

hermana_de(Hermana, Persona) :-
    mama_de(_, Hijos), member(mujer(Hermana), Hijos), member(_, Hijos), Hermana \= Persona,
    (mama_de(_, HijosM), member(HermanaStruct, HijosM), member(PersonaStruct, HijosM),
     (HermanaStruct = mujer(Hermana); HermanaStruct = hombre(Hermana)),
     (PersonaStruct = hombre(Persona); PersonaStruct = mujer(Persona))).

tio_de(Tio, Sobrino) :-
    papa_de(_, Hijos),
    member(Hijo, Hijos),
    (papa_de(Hijo, Nietos); mama_de(Hijo, Nietos)),
    member(N, Nietos),
    (N = hombre(Sobrino); N = mujer(Sobrino)),
    hermano_de(Tio, Hijo), Tio \= Sobrino.

tia_de(Tia, Sobrino) :-
    mama_de(_, Hijos),
    member(Hijo, Hijos),
    (papa_de(Hijo, Nietos); mama_de(Hijo, Nietos)),
    member(N, Nietos),
    (N = hombre(Sobrino); N = mujer(Sobrino)),
    hermana_de(Tia, Hijo), Tia \= Sobrino.

hijo_de(Hijo, PadreOMadre) :-
    (papa_de(hombre(PadreOMadre), Hijos); mama_de(mujer(PadreOMadre), Hijos)),
    member(hombre(Hijo), Hijos).

hija_de(Hija, PadreOMadre) :-
    (papa_de(hombre(PadreOMadre), Hijos); mama_de(mujer(PadreOMadre), Hijos)),
    member(mujer(Hija), Hijos).

primo_de(Primo, Persona) :-
    (papa_de(_, Hijos), member(hombre(PrimoPadre), Hijos),
     (tio_de(PrimoPadre, Persona); tia_de(PrimoPadre, Persona))),
    (papa_de(hombre(PrimoPadre), HijosP), member(hombre(Primo), HijosP));
    (mama_de(mujer(PrimoMadre), HijosM), (tio_de(PrimoMadre, Persona); tia_de(PrimoMadre, Persona))),
    member(hombre(Primo), HijosM).

prima_de(Prima, Persona) :-
    (papa_de(_, Hijos), member(mujer(PrimaPadre), Hijos),
     (tio_de(PrimaPadre, Persona); tia_de(PrimaPadre, Persona))),
    (papa_de(hombre(PrimaPadre), HijosP), member(mujer(Prima), HijosP));
    (mama_de(mujer(PrimaMadre), HijosM), (tio_de(PrimaMadre, Persona); tia_de(PrimaMadre, Persona))),
    member(mujer(Prima), HijosM).

%Grafos-Ciudades 

grafo([
  [vancouver, edmonton, 16],
  [vancouver, calgary, 13],
  [edmonton, saskatoon, 12],
  [calgary, edmonton, 4],
  [calgary, regina, 14],
  [saskatoon, calgary, 9],
  [saskatoon, winnipeg, 20],
  [regina, saskatoon, 7],
  [regina, winnipeg, 4]
]).

arista(G, A, B, C) :- member([A, B, C], G).
arista(G, A, B, C) :- member([B, A, C], G).

tiene_aristas(N) :-
  grafo(G),
  ( arista(G, N, _, _) ; arista(G, _, N, _) ).

tiene_conexiones(Origen) :-
  grafo(G),
  arista(G, Origen, _, _).

costo_nodos(X, Y, Z, CostoTotal) :-
  grafo(G),
  arista(G, X, Y, C1),
  arista(G, Y, Z, C2),
  CostoTotal is C1 + C2.

tiene_conexion(X, Y) :-
  grafo(G),
  arista(G, X, Y, _).

tiene_conexion(X, Y) :-
  grafo(G),
  arista(G, X, Z, _),
  tiene_conexion(Z, Y).

conexiones_salida(Nodo, Lista) :-
  grafo(G),
  conexiones_salida_aux(Nodo, G, Lista).

conexiones_salida_aux(_, [], []).
conexiones_salida_aux(N, [[N, D, C] | R], [[D, C] | L]) :-
  conexiones_salida_aux(N, R, L).
conexiones_salida_aux(N, [[A, N, C] | R], [[A, C] | L]) :-
  conexiones_salida_aux(N, R, L).
conexiones_salida_aux(N, [_ | R], L) :-
  conexiones_salida_aux(N, R, L).

conexiones_totales(Nodo, Lista) :-
  conexiones_salida(Nodo, Lista).

es_libro(popeye).
es_libro(caperucita).
es_libro(pitufos).

es_lector(juan).
es_lector(roberto).
es_lector(juliana).

biblioteca(X,Y):-	(es_libro(X),es_lector(Y));
			(es_libro(Y), es_lector(X)).	




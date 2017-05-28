%--------------Cap 1------------------

juan_come(chocolate,queso,fruta).
pais(espana).
pais(francia).
pais(alemania).

 
le_gusta_pedro(beisbol).
le_gusta_a_juan(X):- le_gusta_pedro(X).

necesita_dinero(olga).
deja_dinero(juan,X):- necesita_dinero(X).

habla_ingles(todos).


direccion_casa(olga,cll_45_n_122-5).
direccion_casa(juana,cll_45_n_122-5).
direccion_casa(fabio,cll_32_n_55B-6).
viven_misma_casa(X,Y):- direccion_casa(X,Z) is direccion_casa(Y,Z).

juega_futbol(juan).
juega_baloncesto(sergio).
es_deportista(X):- juega_futbol(X);juega_baloncesto(X).

padre(juan,fabio).
padre(juan,pedro).
madre(olga,fabio).
madre(olga,pedro).
son_hermanos(X,Y):- padre(Z,X),padre(Z,Y),madre(A,X),madre(A,Y).


a(1).
b(1).
b(2).
b(b).
a(A):-b(B).

c(C):- a(C);b(C).

c(C):- a(C),b(C).

d(D):- a(D),(b(D);c(D)).

si:- not(a(1)) ; b(b).


mujer(olga).
es_madre(X):- madre(X,_).
es_padre(X):- padre(X,_).
es_hijo(X):- madre(_,X);padre(_,X).
hermana_de(X,Y):- ((madre(Z,X), madre(Z,Y),mujer(X));(padre(Z,X),padre(Z,Y),mujer(X))),dif(X,Y).
abuelo_de(X,Y):- padre(X,Z),padre(Z,Y).
hermanos(X,Y):- madre(Z,X), madre(Z,Y).
tia(X,Y):- hermana_de(X,Z),(padre(Z,Y);madre(Z,Y)).

%-----------------Fin-----------------
%----------------Cap 3----------------

suma(X,Y,Z):- Z is X+Y.

densidad(X,Y):- pais(X,P,A), Y is P/A.

%-----------------Fin-----------------
escribir_elementos_lista([]).
escribir_elementos_lista([Cabeza|Cola]):- write(Cabeza),
	                  nl, escribir_elementos_lista(Cola).

pertenece(_,[]):- fail.
pertenece(Elemento,[Cabeza|Cola]):- Elemento is Cabeza ;
				    pertenece(Elemento,Cola) .

contar_elementos(Lista):- contar_elementos(Lista,_).
contar_elementos([],N):- write('Esta lista tiene '), write(N),write(' elemento(s).').
contar_elementos([_|Cola],N):- var(N), %N no tiene algun valor instanciado
	                       N is 1,
			       contar_elementos(Cola,N).

contar_elementos([_|Cola],N):- not(var(N)),
	                       N1 is N+1,
			       contar_elementos(Cola,N1).



hacer(N):-
Resultado is 3+N,
write(Resultado),
nl,
Resultado2 is 3-N,
write(Resultado2).
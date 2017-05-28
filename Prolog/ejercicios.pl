% victoria---kevin			diana---esteban
%          |				      |
%     ----------	      --------------------------------
%     |        |	      |               |	             |
%   oscar    maria----------carlos         catalina	   laura
%     		      |			      |
%	        -------------	         -----------
%               |     |     |	         |         |
%              ana  juan  pedro	       fabio    carolina

% Definir sexo.

es_Hombre(kevin).
es_Hombre(esteban).
es_Hombre(oscar).
es_Hombre(carlos).
es_Hombre(juan).
es_Hombre(pedro).
es_Hombre(fabio).

es_Mujer(victoria).
es_Mujer(diana).
es_Mujer(maria).
es_Mujer(catalina).
es_Mujer(laura).
es_Mujer(ana).
es_Mujer(carolina).

% es_Progenitor(X,Y): X es progenitor (padre o madre) de Y

es_Progenitor(victoria,oscar).
es_Progenitor(victoria,maria).
es_Progenitor(kevin,oscar).
es_Progenitor(kevin,maria).

es_Progenitor(diana,carlos).
es_Progenitor(diana,catalina).
es_Progenitor(diana,laura).
es_Progenitor(esteban,carlos).
es_Progenitor(esteban,catalina).
es_Progenitor(esteban,laura).


es_Progenitor(maria,ana).
es_Progenitor(maria,juan).
es_Progenitor(maria,pedro).
es_Progenitor(carlos,ana).
es_Progenitor(carlos,juan).
es_Progenitor(carlos,pedro).

es_Progenitor(catalina,fabio).
es_Progenitor(catalina,carolina).

% Definiciones de Padre y Madre: X es Padre/Madre de Y.

es_Padre(X,Y)  :-  es_Hombre(X),
	           es_Progenitor(X,Y).

es_Madre(X,Y)  :-  es_Mujer(X),
	           es_Progenitor(X,Y).

% Definiciones de Hijo e Hija: X es Hijo/Hija de Y.

es_Hijo(X,Y)   :-  es_Hombre(X),
	           es_Progenitor(Y,X).

es_Hija(X,Y)   :-  es_Mujer(X),
	           es_Progenitor(Y,X).

% Definiciones de Hermano y Hermana: X es Hermano/Hermana de Y.

es_Hermano(X,Y) :- dif(X,Y),!,
	           es_Hijo(X,Z),
	           es_Progenitor(Z,Y).

es_Hermana(X,Y) :- dif(X,Y),!,
	           es_Hija(X,Z),
	           es_Progenitor(Z,X).

% Definiciones de Abuelo y Abuela: X es Abuelo/Abuela de Y

es_Abuelo(X,Y)  :- es_Padre(X,Z),
		   es_Progenitor(Z,Y).

es_Abuela(X,Y)  :- es_Madre(X,Z),
	           es_Progenitor(Z,Y).


% Definiciones de Nieto y Nieta: X es Nieto/Nieta de Y.

es_Nieto(X,Y)   :- es_Hombre(X),
	           es_Abuelo(Y,X).
es_Nieto(X,Y)	:- es_Hombre(X),
	           es_Abuela(Y,X).

es_Nieta(X,Y)   :- es_Mujer(X),
	           es_Abuelo(Y,X).
es_Nieta(X,Y)   :- es_Mujer(X),
	           es_Abuela(Y,X).

% Definiciones de Tio y Tia:  X es Tio/Tia de Y.

es_Tio(X,Y)     :- es_Hermano(X,Z),
	           es_Progenitor(Z,Y).

es_Tia(X,Y)     :- es_Hermana(X,Z),
	           es_Progenitor(Z,Y).

% Definiciones de Sobrino y Sobrina: X es Sobrino/Sobrina de Y

es_Sobrino(X,Y) :- es_Hombre(X),
	           es_Tio(Y,X).
es_Sobrino(X,Y) :- es_Hombre(X),
		   es_Tia(Y,X).

es_Sobrina(X,Y) :- es_Mujer(X),
	           es_Tio(Y,X).
es_Sobrina(X,Y) :- es_Mujer(X),
	           es_Tia(Y,X).

% Definiciones
















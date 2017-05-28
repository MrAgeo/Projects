global(Nivel_Salud,100).
global(Nivel_Hambre,0).
global(Dias,1).

% cada dia son 5 segs.
comenzar :- verificar_estado,
            decir_sobre("estado"),
            select(5.0),
            un_dia,
            decir_sobre("salir").

% opcion elegida por el usuario

ver_estado :- write("Salud: "),
              write(Nivel_Salud),
              nl,
              write("Hambre: "),
              write(Nivel_Hambre),
              nl,
              write("Dias: "),
              write(Dias),
              nl.


verificar_estado :- ((Nivel_Hambre>20, Nivel_Hambre<50) -> decir_sobre("superhambre");decir_sobre("hambre normal")),
                    ((Nivel_Salud<50, Nivel_Salud>20) -> ((Nivel_Salud<20) -> muerto);muriendo).

% preguntar o decir sobre algo... como por ejemplo el hambre.

decir_sobre(Opcion) :-
	( (Opcion == "estado")
	->
	 write("Quieres ver mi estado [s/n]? "),
	 read(Resp),
	 nl,
		 ( (Resp == S ; Resp == s)
		 ->
		  si(Opcion);
		  nop(Opcion))

		 ;% else

	( (Opcion == "hambre normal")
	->
	 write("Tengo hambre."),nl,write("Me quieres dar comida [s/n]? "),
	 read(Resp),
	 nl,
		 ( (Resp == S ; Resp == s)
		 ->
		  si(Opcion);
		  nop(Opcion))
		 )
	;% else

	( (Opcion == "superhambre")
	->
	 write("Estoy muriendome de hambre."),nl,write("Por Favor!!! darme comida!![s/n]? "),
	 read(Resp),
	 nl,
		 ( (Resp == S ; Resp == s)
		 ->
		  si(Opcion);
		  nop(Opcion))
		 )
	;% else
	( (Opcion == "salir")
	->
	 write("Este es el dia "),write(Dias),write("Quieres salir[s/n]? "),
	 read(Resp),
	 nl,
		 ( (Resp == S ; Resp == s)
		 ->
		  si(Opcion);
		  nop(Opcion))
		 )
	).

un_dia :- ((Nivel_Hambre == 100) -> Nivel_Salud-=10;Nivel_Hambre+=10),
	   Dias+=1,write("----------Dia "),write(Dias),write("----------").

si(Opt) :-( (Opt == "estado")
	->
	 ver_estado

		 ;% else

	( (Opt == "hambre normal")
	->
	 ((Nivel_Hambre==100)-> ((Nivel_Salud==100)-> ;Nivel_Salud+=10);Nivel_Hambre -=10),

	nl
	)
	;% else

	( (Opt == "superhambre")
	->
	 ((Nivel_Hambre==100)-> ((Nivel_Salud==100)-> ;Nivel_Salud+=10);Nivel_Hambre -=10).

	 nl)

	;% else
	( (Opt == "salir")
	->

	)
nop(Opt2) :- ( (Opt2 == "estado")
	    ->

		 ;% else

   	    ( (Opt2 == "hambre normal")
       	    ->

	    nl
	    )
	    ;% else

	    ( (Opt2 == "superhambre")
	    ->

	     nl)

	    ;% else
	    ( (Opt2 == "salir")
	    ->
	    comenzar
	    ).







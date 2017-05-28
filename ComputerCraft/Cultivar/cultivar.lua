
local function send(m1)
	local ret, slot, m = true, 1, ""
	ini, fin = m1:find(" ")
	if ini then
		slot = m1:sub(ini + 1)
		m = m1:sub(1, ini - 1)
	else
		m = m1
	end
    if m == "ar" then
        print ("Moviendo Arriba")
    elseif m == "ab" then
	    print ("Moviendo Abajo")
    elseif m == "der" then
        print ("Girando Derecha")
    elseif m == "izq" then
        print ("Girando Izquierda")
    elseif m == "ad" then
        print ("Moviendo Adelante")
    elseif m == "at" then
        print ("Moviendo Atras")
	elseif m == "pl" then
		if slot <= 16 and slot >=1 then
			print ("Plantando abajo con el slot "..slot)
		else
			print ("Slot no valido: Tiene que ser entre 1 y 16. Se recibio "..slot..".")
			ret = false
		end
	elseif m == "se" then
		if slot <= 16 and slot >=1 then
			print("Seleccionando Slot "..slot)
		else
			print ("Slot no valido: Tiene que ser entre 1 y 16. Se recibio "..slot..".")
			ret = false
		end
	elseif m == "exit" then
		print("Saliendo")
	else
		print("Opcion no valida:"..m)
		ret = false
    end
	return ret
end
local function parcela()
	local voltear_der, voltear, cont, x, y = true, true, 1, 1, 1
	for a = 1, 23 do
		print("\n---------------\n")
		print ("["..x..", "..y.."]")
			if voltear then
			if cont == 2 then
				cont = 0
				voltear = false
				voltear_der = not voltear_der
			end
			
			if voltear_der then
				send("der")
			else
				send("izq")
			end
			
			if cont == 1 then
				for b = 1, 3 do
					send("pl")
					send("ad")
					if voltear_der then
						x = x + 1
					else
						x = x - 1
					end
					print ("["..x..", "..y.."]")
				end
			end
			
			cont = cont + 1
		else
			send("ad")
			y = y + 1
			voltear = true
			print ("["..x..", "..y.."]")
		end
	end
end

local function init()
	--[[ for a=1, 2 do
		send("ab")
	end]]
	parcela()
	send("exit")
end
init()

--[[


if voltear then
				-- Girar izq o der, tomar decision
				--voltea solo 2 veces Mmm...
				-- comprobar contador
				if cont == 2 then
					-- se reinicia el contador de vueltas y no voltea mas :P
					cont = 0
					voltear = false
				elseif cont == 1 then
					voltear = false
					b = b - 1
				end
				-- cada vez que voltea es 1 mas
				cont = cont + 1;
				if voltear_der then
					 -- pues voltea a la derecha, no?, si se acabo el ciclo de giros seguidos voltea izq
					 send("der")
					 if cont == 2 then
						voltear_der = false
					 end
				else
					-- voltea izq tonto :P, si se acabo el ciclo de giros seguidos voltea derecha
					send("izq")
					if cont == 2 then
						voltear_der = true
					end
				end
			else
				-- avanzar, comprobar si es el ultimo cuadro para girar o si avanzo 1 despues de girar
				send("ad")
				if b == 4 or cont == 1 then
					voltear = true
				end
			end
			]]
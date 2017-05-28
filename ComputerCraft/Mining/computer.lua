rednet.open("left")
u_input = io.input()
tpala = {}
tpico = {}
rednet.announce()
tpico.id = rednet.receive()
tpala.id = rednet.receive()
print("ID Tortuga_Pico: "..tpico.id)
print("ID Tortuga_Pala: "..tpala.id)
print("Poner la Tortuga con Pico en la parte de abajo de la (futura) puerta")
os.read()

rednet.close("left")

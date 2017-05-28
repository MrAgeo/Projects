rednet.open("left")
computer = {}
tpico = {}
computer.id = rednet.receive()
tpico.id = rednet.receive()
rednet.announce()

--daemon
repeat



until msg ~= "exit"

rednet.close("left")

rednet.open("left")
computer = {}
tpala = {}
computer.id = rednet.receive()
rednet.announce()
tpala.id = rednet.receive()

--daemon
repeat
rednet.receive


until msg ~= "exit"

rednet.close("left")

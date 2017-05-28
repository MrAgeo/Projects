TrianguloEquilatero = class(Triangulo)

function TrianguloEquilatero:init(s,x,y)
  self:super(s,s,s,x,y)
  self.s = s
end
function TrianguloEquilatero:getSize()
  return self.s
end
function TrianguloEquilatero:toString()
  return "TrianguloEquilatero"
end
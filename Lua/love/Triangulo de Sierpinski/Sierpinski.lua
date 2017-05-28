require "SJTLib"
Sierpinski = class()

function Sierpinski:init(anakin, nDivision, nHijo)
  self.tieneHijos = (nDivision ~= 0)
  size = anakin:getSize()
  pAC, pBC, pAB = anakin:getPoints()
  if nHijo == 1 then
    self.luke = TrianguloEquilatero(size/2, pAC.x, pAC.y)
  elseif nHijo == 2 then
    self.luke = TrianguloEquilatero(size/2, pAC.x + math.abs(pAC.x - pAB.x)/4, pAC.y + (math.abs(pAC.y - pBC.y))/2)
  elseif nHijo == 3 then
    self.luke = TrianguloEquilatero(size/2, (pAC.x + pAB.x)/2, pAB.y)
  else
    self.luke = TrianguloEquilatero(size, pAC.x, pAC.y);
  end
  self.luke:setOriginMode("")
  self.luke:setColor(anakin:getColor())
  if self.tieneHijos then
    self.hijos = {Sierpinski(self.luke, nDivision-1, 1), Sierpinski(self.luke, nDivision-1, 2), Sierpinski(self.luke, nDivision-1, 3)}
  else
    self.hijos =  {self.luke}
  end
end
function Sierpinski:draw()
  for k,v in ipairs(self.hijos) do
    v:draw()
  end
end
Figura = class()

function Figura:init(color, drawMode, x, y)
  self.points = {}
  self.color = color or Colors.WHITE
  self.drawMode = drawMode or "fill"
  self.x = x or window.width/2  -- Position in X
  self.y = y or window.height/2 -- Position in Y
end


function Figura:draw()
  graphics.push()
  graphics.setColor(self.color:getColor())
  graphics.polygon(self.drawMode,self.vertices)--self.drawMode, self.vertices)
  graphics.pop()
end


function Figura:addPoint(p)
  table.insert(self.points, Point(self.x + p.x, self.y + p.y))
  self.vertices = self:getVertices()
end
function Figura:addPoints(pts)
  for k,v in pairs(pts) do
    self:addPoint(v)
  end
end


function Figura:getColor()
  return self.color
end


function Figura:getPoints()
  return self.points
end


function Figura:getVertices()
  vs = {}
  local i = 0
  for k,v in pairs(self.points) do
    i = i + 1
    table.insert(vs,v.x)
    table.insert(vs,window.height-v.y)
  end
  return vs
end


function Figura:getX()
  return self.x
end


function Figura:getY()
  return self.y
end


function Figura:setColor(c)
  self.color = c
end


function Figura:setDrawMode(m)
  self.drawMode = m
end


function Figura:setX(x)
  local oldX, pts = self.x, self:getPoints()
  self.x = x
  
  for k,v in pairs(pts) do
    v.x = v.x - oldX + x
  end
  self.vertices = self:getVertices()
end


function Figura:setY(y)
  local oldY = self.y
  self.y = y
  
  for k,v in pairs(self:getPoints()) do
    v.y = v.y - oldY + y
  end
  self.vertices = self:getVertices()
end


function Figura:removePoints()
  self.points = nil
  self.points = {}
end


function Figura:toString()
  return "Figura"
end
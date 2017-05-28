Rectangulo = class(Figura)

function Rectangulo:init(height, width)
  self:super()
  self.width = width
  self.height = height
  self:updatePoints()
end


function Rectangulo:updatePoints()
  self:removePoints()
  self:addPoints({
                  Point(0, 0), Point(0, self.height), Point(self.width, self.height), Point(self.width, 0)
                 })
end


function Rectangulo:setHeight(h)
  self.height = h
  self:updatePoints()
end


function Rectangulo:setWidth(w)
  self.width = w
  self:updatePoints()
end


function Rectangulo:toString()
  return "Rectangulo"
end
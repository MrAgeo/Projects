Point = class()

function Point:init(x,y)
  self.x = x
  self.y = y
end

function Point:toTable()
  return {self.x, self.y}
end
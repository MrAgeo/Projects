require "SJTLib"

Node = class()

function Node:init(x, y, t)
    self.x = x
    self.y = y
    self.h = nil
    self.g = nil
    self.type = t or Types.NONE
    self.typeChanged = true
    self.r = Cuadrado(l)
    self.r:setX((self.x-1)*l + rightDif)
    self.r:setY(window.height - self.y*l - topDif)
    
    self.a = 225 --215 -- aprox 84,32%
    self.neighbours = {}
    self.parent = nil
    self.savedType = Types.NONE
    self.special = false
    self.opn = false
    self:calcNeighbours()
end


function Node:update()
    if self.typeChanged then
        if self.type == Types.NONE then
            self.r:setColor(ColorMan.RGBgray(10))
        elseif self.type == Types.WALL then
            self.r:setColor(ColorMan.RGBgray(150))
        elseif self.type == Types.START then
            self.r:setColor(Color(0,255,0, self.a))
        elseif self.type == Types.END then
            self.r:setColor(Color(255,0,0, self.a))
        elseif self.type == Types.EXPLORING then
            self.r:setColor(Color(0,0,255, self.a))
        elseif self.type == Types.EXPLORED then
            self.r:setColor(Color(0,240, 255, self.a))
        elseif self.type == Types.PATH then
          self.r:setColor(Color(255,255,0,self.a))
        else
            print("Please use a valid Node type!")
            self.type = Types.NONE
            self.r:setColor(Color(30,30,30))
        end
        self.typeChanged = false
    end
end


function Node:draw()
    self.r:draw()
end


function Node:getType()
    return self.type
end


function Node:isBeingTouched(t)
    local x, y = math.floor(t.x), math.floor(t.y)
    return ((rightDif + (self.x-1)*l) <= x and (rightDif + self.x*l) >= x) and
        ((window.height - topDif - self.y*l) <= y and (window.height - topDif - (self.y-1)*l) >= y)
end


function Node:resetST()
  if not self.special then
    self.savedType = Types.NONE
  end
end


function Node:setType(t)
    self.type = t
    self.typeChanged = true
end


function Node:is(n)
    return n and (n:getX() == self.x and n:getY() == self.y)
end


function Node:getX()
    return self.x
end


function Node:getY()
    return self.y
end


function Node:calcNeighbours()
    self.neighbours = {
    Point(self.x-1, self.y-1), Point(self.x, self.y-1), Point(self.x+1, self.y-1),
    Point(self.x-1, self.y)  ,                          Point(self.x+1, self.y),
    Point(self.x-1, self.y+1), Point(self.x, self.y+1), Point(self.x+1, self.y+1)
    }
    for i,v in ipairs(self.neighbours) do
        if v.x < 1 or v.x > cX then
            table.remove(self.neighbours,i)
        elseif v.y < 1 or v.y > cY then
            table.remove(self.neighbours,i)
        end
    end
end


function Node:getNeighbours()
    return self.neighbours
    
end


function Node:isNeighbour(n)
    local yes = false
    for i,v in ipairs(self.neighbours) do
        if v.x== n:getX() and v.y == n:getY() then
            yes = true
            break
        end
    end
    return yes
end


function Node:saveType()
  self.savedType = self.type
end


function Node:specialNode()
    self.special = true
end


function Node:loadType()
    if self.special then
      self.special = false
    end
    return self.savedType
end


-- ==== A* Algorithm Functions ====

function Node:calcH(n)
    --Manhattan method
    self.h = (math.abs(n:getX() - self.x) + math.abs(n:getY() - self.y))* 10
end


function Node:getH()
  return self.h
end
function Node:getF(n)
  return self.h + self:getG(n)
end

function Node:getG(n)
  local nX = n:getX()
  local nY = n:getY()
  if (nX == (self.x - 1) or nX == (self.x + 1)) or
     (nY == (self.y - 1) or nY == (self.y + 1)) then
         return 10
  elseif (nX == (self.x - 1) or nX == (self.x + 1)) and
         (nY == (self.y - 1) or nY == (self.y + 1)) then
         return 14
  end
end


function Node:setParent(n)
  self.parent = n
end

function Node:getParent()
  return self.parent
end

function Node:isOpen()
  return self.opn
end

function Node:open()
  self.opn = true
end


function Node:close()
  self.opn = false
end
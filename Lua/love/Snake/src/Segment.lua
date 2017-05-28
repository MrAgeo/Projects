require "sjtLib"

Segment = {}
Segment.__index = Segment

function Segment.new(posX, posY, direction)
    local self = setmetatable({}, Segment)
    
    
    self.color = {0, 255, 0, 255}
    self.proxDir = direction
    self.posX = posX
    self.posY = posY    
    
    self.rect = Rect.newSquare(10, false)
    self.rect:setColor(unpack(self.color))
    
    
    return self
end

function Segment.nextDir(self, newDir)
    self.proxDir = newDir
end

function Segment.getDir(self)
    return self.dir
end

function Segment.getPosX(self)
    return self.posX
end

function Segment.getPosY(self)
    return self.posY
end

function Segment.update(self)
    self.dir = self.proxDir
    if self.dir == dirs.UP then
        self.posY = self.posY - 1
    elseif self.dir == dirs.DOWN then
        self.posY = self.posY + 1
    elseif self.dir == dirs.RIGHT then
        self.posX = self.posX + 1
    elseif self.dir == dirs.LEFT then
        self.posX = self.posX - 1
    end
end

function Segment.checkPos(self)
    if self.posX > 58 and self.dir == dirs.RIGHT then
        self.posX = 0
    elseif self.posX < 0 and self.dir == dirs.LEFT then
        self.posX = 58
    end
    
    if self.posY > 58 and self.dir == dirs.DOWN then
        self.posY = 0
    elseif self.posY < 0 and self.dir == dirs.UP then
        self.posY = 58
    end
end


function Segment.draw(self)
    self.rect:draw(10 * self.posX + xMin + 1, yMin + 10 * self.posY + 1)
end
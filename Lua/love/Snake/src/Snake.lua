require "Segment"
require "Food"

ocupados = {}

Snake = {}
Snake.__index = Snake


function Snake.new(posX, posY, direction)
    local self = setmetatable ({}, Snake)
    
    self.posX = posX
    self.posY = posY
    self.dir = direction
    self.food = Food.new()
    
    self.segments = {}
    
    return self
end


function Snake.addSegment(self)
    if #self.segments > 0 then
        local size = #self.segments
        if self.segments[size]:getDir() == dirs.UP then
            table.insert(
                self.segments, Segment.new(
                self.segments[size]:getPosX(),
                self.segments[size]:getPosY() + 1,
                self.segments[size]:getDir()))
        elseif self.segments[size]:getDir() == dirs.DOWN then
            table.insert(
                self.segments, Segment.new(
                self.segments[size]:getPosX(),
                self.segments[size]:getPosY() - 1,
                self.segments[size]:getDir()))
        elseif self.segments[size]:getDir() == dirs.RIGHT then
            table.insert(
                self.segments, Segment.new(
                self.segments[size]:getPosX() - 1,
                self.segments[size]:getPosY(),
                self.segments[size]:getDir()))
        elseif self.segments[size]:getDir() == dirs.LEFT then
            table.insert(
                self.segments, Segment.new(
                self.segments[size]:getPosX() + 1,
                self.segments[size]:getPosY(),
                self.segments[size]:getDir()))
        end
    else
        table.insert(self.segments, Segment.new(self.posX, self.posY, self.dir))
        if self.dir == dirs.UP then
            table.insert(self.segments, Segment.new( self.posX, self.posY + 1, self.dir))
        elseif self.dir == dirs.DOWN then
            table.insert(self.segments, Segment.new(self.posX, self.posY - 1, self.dir))
        elseif self.dir == dirs.RIGHT then
            table.insert(self.segments, Segment.new(self.posX - 1, self.posY, self.dir))
        elseif self.dir == dirs.LEFT then
            table.insert( self.segments, Segment.new(self.posX + 1, self.posY, self.dir))
        end
    end
    if self.dir then
        for i = 1,#self.segments do
            table.insert(ocupados, {x = self.segments[i]:getPosX(), y = self.segments[i]:getPosY()})
        end
        self.food:add()
    end
end


function Snake.update(self)
    self.segments[1]:update()
    for i = 2, #self.segments do
        self.segments[i]:update()
        self.segments[i]:nextDir(self.segments[i-1]:getDir())
    end
end


function Snake.nextDir(self, newDir)
    self.segments[1]:nextDir(newDir)
end

function Snake.setDir(self, dir)
    self.dir = dir
end

function Snake.getDir(self)
    return self.segments[1]:getDir()
end


function Snake.checkPos(self)
    for _,v in ipairs(self.segments) do
        if v:getPosX() == self.food:getPoint().posX and v:getPosY() == self.food:getPoint().posY then
            self.food:destroy()
            self:addSegment()
        end
        v:checkPos()
    end
end


function Snake.draw(self)
    self.food:draw()
    for _,v in ipairs(self.segments) do
        v:draw()
    end
end
require "sjtLib"
Food = {}
Food.__index = Food

function Food.new()
    local self = setmetatable({}, Food)
    self.color = {255, 0, 0, 255}
    self.point = nil
    self.rect = Rect.newSquare(10, false)
    self.rect:setColor(unpack(self.color))
    return self
end

function Food.add(self)
    salir = false
    --love.math.setRandomSeed(love.math.random(0, 9007199300000000))
    x = love.math.random(0, 58)
    y = love.math.random(0, 58)
    repeat
        for _,v in ipairs(ocupados) do
            if v.x == x and v.y == y then
                x = love.math.random(0, 58)
                y = love.math.random(0, 58)
                break
            else
                salir = true
            end
        end
    until salir
    self.point = { posX = x, posY = y}
end


function Food.getPoint(self)
    return self.point
end


function Food.draw(self)
    if self.point then
        self.rect:draw(10 * self.point.posX + xMin + 1, yMin + 10 * self.point.posY + 1)
    end
end

function Food.destroy(self)
    self.point = nil
end
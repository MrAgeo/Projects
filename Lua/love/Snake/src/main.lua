require "Snake"

local dtotal = 0
local listo = false
local pause = false
local limite = 0.12
local grid = false
local sDir = nil
local started = false

dirs = {UP = "up", DOWN = "down", RIGHT = "right", LEFT = "left"}

function love.load()
    window.setTitle("Snake!! By SJT")
    w, h = graphics.getDimensions()
    
    border = Rect.newSquare(590, true)
    border:setColor(0, 0, 0, 255)
    --border:showGrid(true)
    xMin, xMax, yMin, yMax = border:getLimits(w/2,h/2)
    
    snake = Snake.new(29, 29, nil)
    snake:addSegment()
end


function love.update(dt)
    if started then
        if dtotal >= limite then
            listo = true
            dtotal = dtotal - limite
            if not pause then
            snake:update()
            end
        end
        if not pause then
            snake:checkPos()
        end
        dtotal = dtotal + dt
    end
end

function love.keypressed(key, repeated)
    if started then
        if listo and not pause then
            if key == "down" and snake:getDir() ~= dirs.UP and snake:getDir() ~= dirs.DOWN then
                snake:nextDir(dirs.DOWN) --; yGrid = yGrid + 1
            elseif key == "up" and snake:getDir() ~= dirs.UP and snake:getDir() ~= dirs.DOWN then
                snake:nextDir(dirs.UP) --; yGrid = yGrid - 1
            elseif key == "right" and snake:getDir() ~= dirs.RIGHT and snake:getDir() ~= dirs.LEFT then
                snake:nextDir(dirs.RIGHT) --; xGrid = xGrid + 1
            elseif key == "left" and snake:getDir() ~= dirs.RIGHT and snake:getDir() ~= dirs.LEFT then
                snake:nextDir(dirs.LEFT) --; xGrid = xGrid - 1
            end
            listo = false
        end
    else
        if key == "down" then
            sDir = dirs.DOWN
        elseif key == "up" then
            sDir = dirs.UP
        elseif key == "right" then
            sDir = dirs.RIGHT
        elseif key == "left" then
            sDir = dirs.LEFT
        end
    load2()
    end
    if key == "p" then
        pause = not pause
    elseif key == "w" then
        limite = limite - 0.01
    elseif key == "s" then
        limite = limite + 0.01
    end
end

function love.draw()
    border:draw(border:getCenterX(w/2), border:getCenterY(h/2))
    if snake then
        snake:draw()
    end
end

function load2()
    snake = nil
    if sDir == dirs.UP then
        snake = Snake.new(29, 28, sDir)
    elseif sDir == dirs.DOWN then
        snake = Snake.new(29, 30, sDir)
    elseif sDir == dirs.RIGHT then
        snake = Snake.new(30, 29, sDir)
    elseif sDir == dirs.LEFT then
        snake = Snake.new(28, 29, sDir)
    end
    snake:addSegment()
    started = true
    sDir = nil
end
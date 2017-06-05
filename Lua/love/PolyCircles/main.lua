require "PolyCircle"

function love.load()
    f = {}
    r = 30
    angulo = 30
    time = 0
    
    for i=3,30 do
        a = PolyCircle(4,r)
        a:setDrawMode("line")
        a:setColor(hsvToRGB(15*(i-3),1,1))
        table.insert(f, a)
        r = r + 13
    end
end


function love.update(dt)
    time = time + dt
    if time >= 0.01 then
        for k,v in ipairs(f) do
            v:rotate(deg2rad(1))
            if v:getOffAngle() < deg2rad(angulo) then
                break
            end
        end
    time = time - 0.01
    end
end

function love.draw()
    graphics.setLineWidth(1.3)
    for k,v in ipairs(f) do
        v:draw()
    end
end

function deg2rad(deg)
    return math.pi*deg/180
end

function hsvToRGB(h, s, v)
    local c = v*s
    local x = c*(1- math.abs((h/60)%2 - 1))
    local m = v - c
    
    local r, g, b = 0, 0, 0;
    if h >= 360 then
        h = h%360
    elseif h < 0 then
        h = (h%360)+360
    end
    
    if 0 <= h and h < 60 then
        r = c
        g = x
        b = 0
    elseif 60 <= h and h < 120 then
        r = x
        g = c
        b = 0
    elseif 120 <= h and h < 180 then
        r = 0
        g = c
        b = x
    elseif 180 <= h and h < 240 then
        r = 0
        g = x
        b = c
    elseif 240 <= h and h < 300 then
        r = x
        g = 0
        b = c
    elseif 300 <= h and h < 360 then
        r = c
        g = 0
        b = x
    end
    
    return Color((r+m)*255, (g+m)*255, (b+m)*255)
end
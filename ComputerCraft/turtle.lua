local x,y,z = 0,0,0
local sides = {"N", "E", "S", "W", N = 1, E = 2, S = 3, W = 4}
local side = "N"
gps = {}
gps.__index = gps
local private = {}
private.__index = private


function state()
    print(string.format(
    [[
    ###### TURTLE STATE ######
    #  X=%d            Y=%d  #
    #  Z=%d            F=%s  #
    ########## END ###########
    ]], x, y, z, side))
end

function private.side2Int(side)
    return sides[side]
end


function private.int2Side(int)
    if int > 4 then
        int = int % 4
    elseif int == 0 then
            int = 4
    end
        return sides[int]
end


function gps.locate()
    return x, y, z
end

function setFront(s)
    side = s
    state()
end


function forward()
    if side == "N" then
        z = z-1
    elseif side == "S" then
        z = z+1
    elseif side == "E" then
        x = x+1
    elseif side == "W" then
        x = x-1
    end
    state()
end


function back()
    if side == "N" then
        z = z+1
    elseif side == "S" then
        z = z-1
    elseif side == "E" then
        x = x-1
    elseif side == "W" then
        x = x+1
    end
    state()
end


function turnRight()
    side = private.int2Side(private.side2Int(side) + 1)
    state()
end


function turnLeft()
    side = private.int2Side(private.side2Int(side) - 1)
    state()
end

function detect()
    return true
end

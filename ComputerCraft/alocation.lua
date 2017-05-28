Pos = {facing = "FRONT"}
local private = {}
private.__index = private
local m_side = nil
local initialized = false
local moves_queue = {}
mSides = {"N", "E", "S", "W", N = 1, E = 2, S = 3, W = 4}
lSides = {"FRONT", "RIGHT","BACK", "LEFT", FRONT = 1, RIGHT = 2, BACK = 3,  LEFT= 4}
convertSides = {}
sides = lSides

function getFacing()
        return Pos.facing
end


function calibrateFacing()
    if #convertSides == 0 then
        return private.initFacing()
    else
        return false, reasons.already_set
    end
end


-- get the equivalent of a side. Not equal to convertSides!!
function toCurrSides(side)
    mc = false
    r = nil
    for _, v in ipairs(mSides) do
        if side == v then
            mc = true
        end
    end
    if mc then
        r = side2Int_MC(side)
    else
        r = side2Int_L(side)
    end
    return int2Side(r)
end


function side2Int_L(side)
    return lSides[side]
end


function int2Side_L(int)
    if int > 4 then
        int = int % 4
    elseif int == 0 then
            int = 4
    end
    return lSides[int]
end


function side2Int_MC(side)
    return mSides[side]
end


function int2Side_MC(int)
    if int > 4 then
        int = int % 4
    elseif int == 0 then
            int = 4
    end
        return mSides[int]
end


function side2Int(side)
    return sides[side]
end


function int2Side(int)
    if int > 4 then
        int = int % 4
    elseif int == 0 then
        int = 4
    end
    return sides[int]
end


-- returns the opposite side in String
function oppSide(side)
    if type(side) == "string" then
        return int2Side(side2Int(side) + 2)
    else
        return int2Side(side + 2)
    end
end


-- Updates the turtle's position in MC
function updateGPS()
    Pos.x, Pos.y, Pos.z = gps.locate()
end


-- turns towards a side
function turn(side)
    if (side2Int(Pos.facing) + 1) == side2Int(side) then
        turtle.turnRight()
    elseif (side2Int(Pos.facing) - 1) == side2Int(side) then
        turtle.turnLeft()
    else
        turtle.turnRight()
        turtle.turnRight()
    end
    Pos.facing = side
end


function turnRight(times)
    times = times or 1
    for i=1, times do
        turn(int2Side(side2Int(Pos.facing) + 1))
    end
end


function turnLeft(times)
    times = times or 1
    for i=1, times do
        turn(int2Side(side2Int(Pos.facing) - 1))
    end
end


function forward(blocks)
    blocks = blocks or 1
    for i=1,blocks do
        turtle.forward()
    end
    updateGPS()
end


function back(blocks)
    blocks = blocks or 1
    for i=1,blocks do
        turtle.back()
    end
    updateGPS()
end


function up(blocks)
    blocks = blocks or 1
    for i=1, blocks do
        turtle.up()
    end
    updateGPS()
end


function down(blocks)
    blocks = blocks or 1
    for i=1, blocks do
        turtle.down()
    end
    updateGPS()
end


--[[ Analise if there are blocks around the turtle. (No UP nor DOWN)
     Stops turning if there's a space when stop=true; otherwise it saves
     the side value.
     Returns false,table/str if there's an space, else: true, nil
  ]]
function aBlocks(stop)
    stop = stop or false
    trapped = true
    count = 1 -- 1 = Front 2 = Right, 3 = Back, 4 = Left
    repeat
        if count == 5 then
            if not trapped then
                count = aux
            else
                count = nil
            end
            break
        end
        block = turtle.detect()
        if not block then
            trapped = false
            if stop then
                count = sides[count]
                break
            else
                block = true
                if aux then
                    table.insert(aux, sides[count])
                else
                    aux = {}
                end
            end
        end
        turnRight()
        count = count + 1
    until block
    return trapped, count
end


-- If the turtle can move up, down, left, right, forwards or backwards (Doesn't detect entities)
function canMove(stop)
    stop = stop or false
    trapped, count = aBlocks(stop)
    up = falselocate()
    tbl = false
    aux = nil
    if type(count) == "table" then
        tbl = true
    else
        aux = {}
    end
    if turtle.up() then
        trapped = false
        up = true
        if tbl then
            table.insert(count, "UP")
        else
            table.insert(aux, "UP")
        end
        if not stop then
            turtle.down()
        end
    end
    if not up then
        if turtle.down() then
            if tbl then
                table.insert(count, "DOWN")
            else
                table.insert(aux, "DOWN")
            end
            if not stop then
                turtle.up()
            end
        end
    end
    if not tbl then
        if count then
            count = {count}
            for i,v in ipairs(aux) do
                table.insert(count, v)
            end
        else
            count = aux
        end
    end
    return trapped, count
end


-- Make the moves / empty the moves_queue
function private.makeInitMoves()
    local moves =
    {
        FRONT = turtle.forward,
        RIGHT = function ()
                    turtle.turnRight()
                    turtle. forward()
                    turtle.turnLeft()
                end,
        BACK = turtle.back,

        LEFT = function ()
                    turtle.turnLeft()
                    turtle. forward()
                    turtle.turnRight()
                end,
        UP = turtle.up,
        DOWN = turtle.down
    }
    for i=1, #moves_queue do
        moves[table.remove(moves_queue)]()
    end
end


-- Determine (if possible) the facing of the turtle (acording to MC's N, S, E and W)
function private.initFacing()
    set = false -- if it's successfully set
    trapped, count = aBlocks(true)
    reason = nil

    if trapped then
        print("OMG I'm trapped on Z="..tostring(Pos.z).."!!! Stupid Blocks!!")
        print("Going Up...")
        if turtle.up() then
            trapped, count = aBlocks(true)

            if trapped then
                print("Last Chance: Down....")
                turtle.down()
            else
                table.insert(moves_queue, oppSide(count))
                table.insert(moves_queue, "DOWN")
            end
        else
            print("Last Chance: Down....")
        end
        if turtle.down() then
            trapped, count = aBlocks(true)
            if trapped then
                print("Nope...")
                turtle.up()
                reason = reasons.trapped
            else
                table.insert(moves_queue, oppSide(count))
                table.insert(moves_queue, "UP")
            end
        end
    else
        table.insert(moves_queue, oppSide(count))
    end
    if not trapped then
        set = true
        turtle.forward()
        f = count
        tries = 0
        repeat
            tries = tries + 1
            x, _, z = gps.locate()
        until (not (x and z)) or tries <= 20
        if x and z then
            if x > Pos.x then --facing East
                sides = mSides
                Pos.facing = "E"
            elseif x < Pos.x then -- West
                sides = mSides
                Pos.facing = "W"
            elseif z > Pos.z then -- South
                sides = mSides
                Pos.facing = "S"
            elseif z < Pos.z then -- North
                sides = mSides
                Pos.facing = "N"
            else -- didn't move
                set = false
            end
        else
            set = false
            reason = reasons.no_gps
        end
        if set then
            dif = math.abs(side2Int(Pos.facing) - side2Int_L(f))
            for i=0,3 do
                -- Local to MC
                convertSides[int2Side_L(side2Int_L(f) + i + dif)] = int2Side(side2Int(Pos.facing) + i + dif)
                -- MC to Local
                convertSides[int2Side(side2Int(Pos.facing) + i + dif)] = int2Side_L(side2Int_L(f)+ i + dif)
            end
        end
    end
    private.makeInitMoves()
    return set, reason
end

function close()
    rednet.close(m_side)
end


-- prepare everything
function init(withFacing)
    pass = false
    for _, v in ipairs(rs.getSides()) do
        t = peripheral.getType(v)
        if t == "modem" then
            pass = true
            m_side = v
        end
    end
    assert(pass, "[alocation] This API needs a wireless modem!!")
    --os.loadAPI("/rom/apis/utils")
    rednet.open(m_side)
    withFacing = withFacing or true
    updateGPS()
    if withFacing then
        set, reason = private.initFacing()
        if set then
            print("Facing set:"..Pos.facing)
        else
            print("WARNING: Facing couldn't set!! Reason: '"..reason.."'\nUsing Local Sides...")
        end
    else
            print("WARNING: Facing not set!! This might not work!\nUsing Local Sides...")
    end
    initialized = true
    return true, Pos
end

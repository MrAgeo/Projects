local String = nil
local moves_queue = {limit = 20}
local movements = {
          turn = function (side)
                     alocation.turn(alocation.toCurrSide(side))
                 end,
          fw =   function (blocks)
                     alocation.forward(blocks)
                 end,
          up =   function (blocks)
                     alocation.up(blocks)
                 end,
          down = function (blocks)
                     alocation.down(blocks)
                 end
      }

Pos = nil

function addMove(move)
    if #moves_queue == moves_queue.limit then
        --TODO: wait
    else
        table.insert(moves_queue, String(move))
    end
end


function makeMoves()
        set, reason = alocation.calibrateFacing()
        cont = true
        if not (set and reason ~= reasons.already_set) then
            print("WARNING: Couldn't set the Facing! This Might not Work as expected..\n Reason: '"..reason"'.")
            print("Continue? [y/N] ")
            r = io.read()
            if not (r == "y" or r == "Y") then
                cont = false
            end
        end
        if cont then
            cmds = {}
            args = {}
            for _, v in ipairs(moves_queue) do
                s = v:find(" ")
                table.insert(cmds,v:sub(1,s-1))
                table.insert(args,v:sub(s+1))
            end
            for i=1,#moves_queue do
                movements[cmds[i]](args[i])
            end
        end
end


function main(args)
    tgt=nil
    String = utils.String
    aux = {}
    for _,v in ipairs(args) do
        table.insert(aux, String(v))
    end
    pass, Pos = alocation.init()
    if pass then
        tgt = {}
        print(tostring(aux[1]:endsWith("x")))
        assert(false, "#### BreakPoint_1 ####")
        for _,v in ipairs(aux) do
            if v:endsWith("x") and v:len() > 1 then
                r = v:toNumber(1,v:len()-1)
                if r then
                    tgt.x = r
                else
                    print("'"..v:sub(1,v:len()-1).."' is not a valid number!")
                    tgt.x = Pos.x
                end
            end
            if v:endsWith("y") and v:len() > 1 then
                r = v:toNumber(1,v:len()-1)
                if r then
                    tgt.y = r
                else
                    print("'"..v:sub(1,v:len()-1).."' is not a valid number!")
                    tgt.y = Pos.y
                end
            end
            if v:endsWith("z") and v:len() > 1 then
                r = v:toNumber(1,v:len()-1)
                if r then
                    tgt.z = r
                else
                    print("'"..v:sub(1,v:len()-1).."' is not a valid number!")
                    tgt.z = Pos.z
                end
            end
        end

        if Pos.x < tgt.x then
            addMove("turn E")
            addMove("fw "..tostring(tgt.x - Pos.x))
        elseif Pos.x > tgt.x then
            addMove("turn W")
            addMove("fw "..tostring(Pos.x - tgt.x))
        end
        print(tostring(tgt.z))
        if Pos.z < tgt.z then
            addMove("turn S")
            addMove("fw "..tostring(tgt.x - Pos.x))
        elseif Pos.z > tgt.z then
            addMove("turn N")
            addMove("fw "..tostring(Pos.x - tgt.x))
        end

        if Pos.y < tgt.y then
            addMove("up "..tostring(tgt.x - Pos.x))
        elseif Pos.y > tgt.y then
            addMove("down "..tostring(Pos.x - tgt.x))
        end
        makeMoves()
    else
        print("[moveto] Alocation couldn't inilialized!!")
    end
    print("[moveto] Exiting...")
    if pass then
        alocation.close()
    end
end
main({...})

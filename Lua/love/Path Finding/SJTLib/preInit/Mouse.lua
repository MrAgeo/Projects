
-- === SJTLib MouseListener ===
--     By Sergio JT (2017)


local mouseListenerEnabled = false
local hasTouchBegun = false
local detectMode = 1; -- AsTouch
local _Mouse = {}
_Mouse.BEGAN = false
_Mouse.MOVING = false
_Mouse.ENDED = false
_Mouse.x = nil
_Mouse.y = nil
Mouse = {}

-- Default functions
Mouse.asTouch = function(t) end
Mouse.asNormal = function(t) end
Mouse.asMixed = function(t) end

local listenerFn = function ()
    if detectMode == 1 then
        Mouse.asTouch(_Mouse)
    elseif detectMode == 2 then
        Mouse.asNormal(_Mouse)
    elseif detectMode == 3 then
        Mouse.asMixed(_Mouse)
    end
end


function Mouse.enableMouseListener(mode)
    
    local m = mode or "touch"
    
    if mode == "touch" then
        print "Called AsTouch"
      detectMode = 1
    elseif m == "normal" then
      detectMode = 2
    elseif m == "mixed" then
      detectMode = 3
    else
        -- print "MouseDetectionMode not valid: Only touch, normal or mixed is allowed"
        detectMode = 1
    end
    
    -- === LÖVE Functions ===
    
    function love.mousepressed(x,y,m)
        if m == "l" or m == 1 then
            _Mouse.BEGAN = true
            hasTouchBegun = true
        end
        listenerFn()

        _Mouse.BEGAN = false
    end


    function love.mousemoved(x,y,dx,dy)
        _Mouse.MOVING = true
        _Mouse.x = x
        _Mouse.y = window.height-y
        if (detectMode == 1) and hasTouchBegun then
            listenerFn()
        elseif detectMode~=1 then
            listenerFn()
        end
        _Mouse.MOVING = false
    end


    function love.mousereleased(x,y,m)
        if m == "l" or m == 1 then
            _Mouse.ENDED = true
            hasTouchBegun = false
        end
        listenerFn()
  
        _Mouse.ENDED = false
    end

-- === END LÖVE Functions ===
    mouseListenerEnabled = true
end

function Mouse.disableMouseListening()
    mouseListenerEnabled = false
end

function Mouse.isMouseListenerEnabled()
    return mouseListenerEnabled
end
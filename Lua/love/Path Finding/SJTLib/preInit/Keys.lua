KC = {
      ESCAPE = "escape", 
      A = "a", B = "b", C = "c", D = "d", E = "e", F = "f", G = "g", H = "h", I = "i", J = "j", K = "k", L = "l", M = "m",
      N = "n", O = "o", P = "p", Q = "q", R = "r", S = "s", T = "t", U = "u", V = "v", W = "w", X = "x", Y = "y", Z = "z",
      F1 = "f1", F2 = "f2", F3 = "f3", F4 = "f4", F5 = "f5", F6 = "f6", F7 = "f7", F8 = "f8", F9 = "f9", F10 = "f10", F11 = "f11", F12 = "f12", 
      NUM0 = "0", NUM1 = "1", NUM2 = "2", NUM3 = "3", NUM4 = "4", NUM5 = "5", NUM6 = "6", NUM7 = "7", NUM8 = "8", NUM9 = "9",
      UP = "up", DOWN = "down", LEFT = "left", RIGHT = "right"
    }
    
-- Default KeyPressed Function
keypressed = function(k) end

love.keyboard.setKeyRepeat(true)

function love.keypressed(k,b)
  local tk = {}
  function tk.isRepeated()
    return b
  end
  function tk.is(key)
    return k == key
  end
  function tk.getKey()
    return k
  end
  keypressed(tk)
end
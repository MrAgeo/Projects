reasons = {trapped = "I'm trapped!!", already_set = "It's already set!!", no_gps = "Couldn't get the position.\nMaybe the turtle doesn't have a wireless modem you don have a GPS Satellite..."}
String = {}
String.__index = String

setmetatable(String, {
             __call = function (cls, ...)
                          return cls.new(...)
                      end})

function String.new(str)
    local self = setmetatable({}, String)
    self.str = str
    return self
end


function String:byte(i, j)
        return string.byte(self.str, i, j)
end


function String:endsWith(s)
    return string.sub(self.str,-#s) == s
end


function String:find(pattern, init, plain)
    return string.find(self.str, pattern, init, plain)
end


function String:get()
    return self.str
end


function String:gmatch(pattern)
    return string.gmatch(self.str, pattern)
end


function String:gsub(pattern, repl, n)
    return string.gsub(self.str, pattern, repl, n)
end


function String:len()
    return #self.str
end


function String:lower()
    return string.lower(self.str)
end


function String:match(pattern, init)
    return string.match(self.str, pattern, init)
end


function String:rep(n)
    return string.rep(self.str, n)
end


function String:reverse()
    return string.reverse(self.str)
end


function String:set(str)
    assert(type(str) == "string", "I only accept Strings!!")
    self.str = str
end


function String:startsWith(s)
    return string.sub(self.str, 1, #s) == s
end


function String:sub(i, j)
    return string.sub(self.str, i, j)
end


function String:toNumber(i, j)
    i = i or 1
    j = j or #self.str
    return tonumber(self:sub(i,j))
end

function String:upper()
    return string.upper(self.str)
end

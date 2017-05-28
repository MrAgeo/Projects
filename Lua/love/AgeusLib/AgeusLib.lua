if MOAIEnvironment then
    require "MoaiLib"
elseif love then
    require "LoveLib"
else
    require "LuaLib"
end
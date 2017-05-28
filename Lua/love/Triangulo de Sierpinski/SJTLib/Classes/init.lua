__isSJTLoaded = true
local current_folder = (...):gsub('%.[^%.]+$', '') .. ".Classes"
local cls = {"Color", "Point", "Figura", "Triangulo", "TrianguloEquilatero", "Rectangulo", "Cuadrado"}
local function req()
  for k,v in pairs(cls) do
    require(current_folder .."."..v)
  end
end
req()


function vec2(x,y)
  local t = {}
  t.x = x or 0
  t.y = y or 0
  return t
end

function vec3(x,y,z)
  local t = {}
  t.x = x or 0
  t.y = y or 0
  t.z = z or 0
  return t
end


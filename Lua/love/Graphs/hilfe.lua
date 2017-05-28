require "numlu"
function color(r,g,b,a)
  return {r or 255, g or 255, b or 255, a or 255}  
end

function vec2(x,y)
  return {x = x or 0, y = y or 0}
end

function vec3(x,y,z)
  return {x = x or 0, y = y or 0, z = z or 0}
end

ecuaciones = {}

function ecuaciones.mx_b(s)
  local inicioX = string.find(s,'x')
  local m, b = nil, nil
  
  if inicioX then
    m = numlu.toNumber(string.sub(s,1,inicioX-1))
    if string.sub(s,inicioX+1) == "" then
      b = 0
    else
      b = numlu.toNumber(string.sub(s,inicioX+1))
    end
    print("y = "..tostring(m).."x + "..tostring(b))
  end
end
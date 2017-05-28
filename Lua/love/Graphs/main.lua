require "hilfe"

function love.load()
  wWidth, wHeight = love.window.getDimensions()
  origen = vec2(wWidth/2,wHeight/2)
  unidad = 50
  einheitlinie = 7
  cambio = 1
  drawGrid = false
  love.keyboard.setKeyRepeat(true)
  font = love.graphics.newFont(14)
  ecuaciones.mx_b("-c2x")
end

function love.update(dt)
  love.event.quit()
end


function love.draw()
  love.graphics.setColor(color(255,0,0))
  love.graphics.setFont(font)
  love.graphics.line({0, wHeight - origen.y,wWidth, wHeight - origen.y})
  love.graphics.print("x",0, wHeight - origen.y - font:getHeight("x") - einheitlinie - 3 )
  love.graphics.print("y",origen.x + font:getWidth("y") + einheitlinie, 0)
  love.graphics.line({origen.x, 0,origen.x, wHeight})
  for ux=1,(wWidth-origen.x)-(wWidth-origen.x)%unidad do
    love.graphics.line({origen.x + ux*unidad, wHeight - (origen.y + einheitlinie),origen.x + ux*unidad, wHeight - (origen.y - einheitlinie)})
  end
  for ux=1,(origen.x - origen.x%unidad) do
    love.graphics.line({origen.x - ux*unidad, wHeight - (origen.y + einheitlinie),origen.x - ux*unidad, wHeight - (origen.y - einheitlinie)})
  end
  
  for uy=1,(wHeight - origen.y)-(wHeight-origen.y)%unidad do
    love.graphics.line({origen.x - einheitlinie, wHeight - (origen.y + uy*unidad),origen.x + einheitlinie, wHeight - (origen.y + uy*unidad)})
  end
  for uy=1,(origen.y - origen.y%unidad) do
    love.graphics.line({origen.x - einheitlinie, wHeight - (origen.y - uy*unidad),origen.x + einheitlinie, wHeight - (origen.y - uy*unidad)})
  end
  
end

function love.keypressed(key, repeated)
  if key == "up" and not (origen.y + cambio > wHeight) then
    origen.y = origen.y + cambio
  elseif key == "down" and not (origen.y - cambio < 0) then
    origen.y = origen.y - cambio
  elseif key == "right" and not (origen.x + cambio > wWidth) then
    origen.x = origen.x + cambio
  elseif key == "left" and not (origen.x - cambio < 0) then
    origen.x = origen.x - cambio
  elseif key == "g" and not repeated then
    drawGrid = not drawGrid
  end
end
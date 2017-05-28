require "SJTLib"

function love.load()
    a = "Hola Mundo!"
    b = 0
    love.window.setFullscreen(true,"desktop")
end


function love.draw()
  graphics.setBackgroundColor(RGBgray(50))
  width, height = window.getDimensions()
  graphics.circle("fill", width/2,height/2,200)

end

function love.update(dt)
  if b >= 3 then
    love.event.quit()
  else
    b = b + dt
  end

end

require "Sierpinski"

function love.load()
  contador = 0
  a = 1000
  --i = 5
  --nums = {1, 5, 10, 50, 100, 200, 500}
  window.setFullscreen(true,"desktop")
  window.setTitle("Sierpinski")
  
  t = TrianguloEquilatero(a, window.width/2-a/2, (window.height-math.sqrt(a^2-a^2/4))/2)
  t:setOriginMode("")
  t:setColor(ColorMan.RGBgray(180))
  s = Sierpinski(t,0)
  
  font = graphics.newFont(35)
  graphics.setFont(font)
  pX = (window.width - font:getWidth("Numero de Divisiones: "..tostring(contador)))/2
end

function love.update(dt)
end

function love.keyreleased(key)
  if key == "up" then
    contador = contador + 1
  elseif key == "down" then
    if contador ~= 0 then
      contador = contador - 1
    end
  elseif key == "escape" then
    closeLove2d()
  end
  pX = (window.width - font:getWidth("Numero de Divisiones: "..tostring(contador)))/2
  s = Sierpinski(t,contador)
end

function love.draw()
  s:draw()
  graphics.setColor(Colors.WHITE:getColor())
  graphics.print("Numero de Divisiones: "..tostring(contador), pX, 0)
end
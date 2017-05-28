-- Path Finding
-- ### Encontrar forma de buscar SJTLib ###
require "SJTLib"
require "Matrix"

-- Global Vars
cX, cY = nil, nil -- Cuadrados en X Y
rightDif, leftDif, topDif, bottomDif = nil, nil, nil, nil
undo = false
cleared = true
fullS = true
l = 30 -- Largo del Nodo

-- Node Types
Types = {}
Types.WALL = -1
Types.NONE = 0
Types.START = 1
Types.END = 2
Types.EXPLORING = 3
Types.EXPLORED = 4
Types.PATH = 5
  
function calculateVars()
  cX = (window.width - window.width%l)/l -- quitar decimales con MOD
  cY = (window.height - window.height%l)/l
  rightDif = window.width%(cX*l)/2
  topDif = window.height%(cY*l)/2
  
  while rightDif < 20 do
    cX = cX - 1
    rightDif = window.width%(cX*l)/2
  end
  while topDif < 20 do
    cY = cY - 1
    topDif = window.height%(cY*l)/2
  end
  bottomDif = topDif
  leftDif = rightDif
end

function love.load()
  window.setTitle("Pathfinding - Por SJT")
  Mouse.enableMouseListener()
  
  -- === VARIABLES ===
  calculateVars()
  
  mtx = Matrix() --Crear una nueva matriz de Nodos
end


function love.update()
  if mtx then
    mtx:update()
  end
end


function love.draw()
  if mtx then
    mtx:draw()
    drawGrid() --dibujar la cuadricula
  end
end


function keypressed(key)
    if key.is(KC.ESCAPE) then
      closeLove2d()
    elseif key.is(KC.NUM1) then
      if cleared then
        mtx:removeW()
      else
        mtx:clear()
      end
    elseif key.is(KC.NUM2) then
      mtx:resumeOrPause()
    elseif key.is(KC.F11) then
      window.setFullscreen(fullS)
      fullS = not fullS
      mtx = nil
      calculateVars()
      mtx = Matrix()
    elseif key.is(KC.N) then
      mtx:next()
    end
end

function Mouse.asTouch(t)
  if mtx then
    mtx:touched(t)
  end
end


function drawGrid()
  graphics.push()
  graphics.setColor(ColorMan.RGBgray(220):getColor())
  graphics.setLineWidth(1)
  graphics.setLineStyle("rough")
  for i=0, cX do
    graphics.line(rightDif + l*i, window.height - topDif, rightDif + l*i, bottomDif)
  end
  for i=0, cY do
    graphics.line(rightDif, topDif + l*i, window.width - leftDif, topDif + l*i)
  end
  graphics.pop()
end
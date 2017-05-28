
function oscillator(freq)
    local phase = 0
    return function()
        phase = phase + 2*math.pi/rate            
        if phase >= 2*math.pi then
            phase = phase - 2*math.pi
        end
        return math.sin(freq*phase)
    end
end
function freq(nota, octava)
  return 440.0*math.exp(((octava-4) + (nota-10)/12.0)*math.log(2.0))
end

function love.load()
  
  notas = {
           "Do"  , "Do#", "Re" , "Re#",
           "Mi"  , "Fa" , "Fa#", "Sol",
           "Sol#", "La" , "La#", "Si"
          }
  
  curN = 10
  curOct = 4
  curFreq = freq(curN,curOct)
  suena = false
  sonando = false
  
  len = 1 -- en segundos
  rate = 44100
  bits = 16
  channels = 1
  amplitude = 1
  soundData = love.sound.newSoundData( len*rate, rate, bits, channels)
  
  
  love.window.setFullscreen(true,"desktop")
  width, height = love.window.getDimensions()
end

function love.update(dt)
  if suena then
    if not sonando then
      love.audio.play(source)
      sonando = true
    end
  else
    love.audio.stop()
    sonando = false
  end
end

function love.draw()
    love.graphics.setBackgroundColor({0,0,0,255})
    love.graphics.setFont(love.graphics.newFont(30))
    love.graphics.setColor({255,255,255,255})
    h = love.graphics.getFont():getHeight()
    love.graphics.print("Octava: "..tostring(curOct), (width-love.graphics.getFont():getWidth("Octava: "..tostring(curOct)))/2, height/6 + 3)
    love.graphics.setFont(love.graphics.newFont(90))
    love.graphics.print(notas[curN], (width- love.graphics.getFont():getWidth(notas[curN]))/2, height/6-love.graphics.getFont():getHeight()/2-h-3)
    love.graphics.setFont(love.graphics.newFont(110))
    love.graphics.setColor({255, 220,150,255})
    s = string.sub(tostring(curFreq),1,string.find(tostring(curFreq),'.')+6).."Hz"
    love.graphics.print(s, (width-love.graphics.getFont():getWidth(s))/2,(height-love.graphics.getFont():getHeight())/2)
end

function love.keypressed(key)
  if key == " " then
      suena = not suena
  elseif key == "escape" then
    love.audio.stop()
    love.event.quit()
  end
  if not suena then
    if key == "up" then
      curOct = curOct + 1
      if curOct > 10 then
        curOct = 0
      end
    elseif key == "down" then
      curOct = curOct - 1
      if curOct < 0 then
        curOct = 10
      end
    elseif key == "left" then
      curN = curN - 1
      if curN < 1 then
        curN = 12
        love.keypressed("down")
      end
    elseif key == "right" then
      curN = curN + 1
      if curN > 12 then
        curN = 1
        love.keypressed("up")
      end
    end
  end
  curFreq = freq(curN,curOct)
  osc = oscillator(curFreq)
  for i=0, len*rate-1 do
    local sample = osc()*amplitude
    soundData:setSample(i, sample)
  end
  source = love.audio.newSource(soundData)
  source:setLooping(true)
end

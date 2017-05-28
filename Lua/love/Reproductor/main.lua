function oscillator(freq, signal_type)
    local fase = 0
    s_type = signal_type or "sin"
    return function()
        fase = fase + 2*math.pi/rate            
        if fase >= 2*math.pi then
            fase = fase - 2*math.pi
        end
        if s_type == "sin" then
          return math.sin(freq*fase)
        elseif s_type == "sqr" then
          local pos = math.sin(freq*fase)
          if pos > 0 then
            return 1
          elseif pos < 0 then
            return -1
          elseif pos == 0 then
            return 0
          end
        end
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
  
  curFreq = freq(curN,curOct)
  osc = oscillator(curFreq)
  osc2 = oscillator(freq(curN-4, curOct), "sqr")
  
  for i=0, len*rate-1 do
    local sample = osc()*amplitude
    soundData:setSample(i, sample)
  end
  
  source = love.audio.newSource(soundData)
  source:setLooping(true)
  
  for i=0, len*rate-1 do
    local sample = osc2()*amplitude
    soundData:setSample(i, sample)
  end
  
  src2 = love.audio.newSource(soundData)
  src2:setLooping(true)
  
  love.window.setFullscreen(true,"desktop")
end

function love.update(dt)
  if suena then
    if not sonando then
      source:play()
      src2:play()
      sonando = true
    end
  else
    love.audio.stop()
    sonando = false
  end
end
function love.keypressed(key)
  if key == "space" then
      suena = not suena
  elseif key == "escape" then
    love.audio.stop()
    love.event.quit()
  end
end

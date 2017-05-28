require "SJTLib"

SHRT_MAX = 32767
CHAR_MAX = 127

function love.load()
    --love.filesystem.setIdentity("SoundSynth_saveDir")
    --[[
    length = 8
    rate = 44100
    sD = love.sound.newSoundData(length*rate, rate, 16, 1)
    
    osc = Oscillator()
    osc:create()
    for i=1, 2*rate-1 do
        sD:setSample(i, osc:nextValue())
    end
    osc:reset()
    osc:setType("saw")
    osc:setMaxAmp(0.7)
    osc:create()
    for i=2*rate,4*rate-1 do
        sD:setSample(i, osc:nextValue())
    end
    osc:reset()
    osc:setType("triangle")
    osc:setMaxAmp(1)
    osc:create()
    for i=4*rate, 6*rate-1 do
        sD:setSample(i, osc:nextValue())
    end
    osc:reset()
    osc:setType("square")
    osc:setMaxAmp(0.7)
    osc:create()
    for i=6*rate, 8*rate-1 do
        sD:setSample(i, osc:nextValue())
    end
    file = FileIO.newFile("out.1raw")
    file:write(sD:getString())
    
    ---#### Part 2 ###
    rate = 44100
    sample = 0.00001
    sD = love.sound.newSoundData(1, rate, 8, 1) -- samples, rate, nit_depth, channels
    sD:setSample(0, sample)
    str = sD:getString()
    b1 = Helper.separateInBytes(Helper.decimalToBin(str:byte(1)))
    print("\n\n#### CHAR (BIT DEPTH 8) #####\n")
    print(unpack(b1))
    print("-----")
    print(unpack(Helper.separateInBytes(Helper.floatToIEEE754_32(sample*CHAR_MAX))))
    print("-----")
    print(unpack(Helper.separateInBytes(Helper.floatToIEEE754_16(sample*CHAR_MAX))))
    
    sD = love.sound.newSoundData(1, rate, 16, 1)
    sD:setSample(0, sample)
    str = sD:getString()
    b1 = Helper.separateInBytes(Helper.decimalToBin(str:byte(1)))
    b2 = Helper.separateInBytes(Helper.decimalToBin(str:byte(2)))
    print("\n\n#### SHORT (BIT DEPTH 16) #####\n")
    print(unpack(b1),unpack(b2))
    print(unpack(Helper.separateInBytes(Helper.floatToIEEE754_32(sample*SHRT_MAX))))
    print(unpack(Helper.separateInBytes(Helper.floatToIEEE754_16(sample*SHRT_MAX))))
    --]]
    
    print(unpack(Helper.separateInBytes(Helper.decimalToBin(3212836864))))
    print(unpack(Helper.separateInBytes(Helper.floatToIEEE754_32(-1))))
    print(Helper.castFloatToInt(1))
    print(4294967294/2)
    
    love.window.close()
    love.event.quit()
end


function love.draw()
end
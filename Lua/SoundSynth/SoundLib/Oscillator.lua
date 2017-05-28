Oscillator = class()

function Oscillator:init(freq, phase, rate, oscT)
    self.oscType = oscT or "sine"
    self.freq = freq or 440
    self.phase = phase or 0
    self.rate = rate or 44100
    self.maxAmp = 1;
    self.osc = self.phase
end


function Oscillator:create()
   self.started = true
end


function Oscillator:nextValue()
    if self.started then
        self.osc = self.osc + 2*math.pi/self.rate
        if self.osc >= 2*math.pi then
            self.osc = self.osc - 2*math.pi
        end
    
        if self.oscType == "saw" then
            self.curAmp = 2*(self.freq*self.osc/(2*math.pi) - math.floor(0.5 + self.freq*self.osc/(2*math.pi)))*self.maxAmp
        elseif self.oscType == "triangle" then
            self.curAmp = (2*self.freq*(self.osc/(math.pi) - (1/self.freq)*math.floor(self.freq*self.osc/math.pi + 0.5))*(-1)^math.floor(self.freq*self.osc/math.pi + 0.5))*self.maxAmp
        elseif self.oscType == "square" then
            self.curAmp = ((-1)^math.floor(self.freq*self.osc/math.pi))*self.maxAmp
        else
            self.curAmp = math.sin(self.freq*self.osc)*self.maxAmp
        end
        return self.curAmp
    else
        return 0
    end
end


function Oscillator:reset()
    self.started = false
    self.curAmp = nil
    self.osc = self.phase;
end


function Oscillator:setFrequency(freq)
    if not self.started then
        self.freq = freq
    end
end


function Oscillator:setMaxAmp(mxAmp)
    if not self.started then
        self.maxAmp = mxAmp
    end
end


function Oscillator:setPhase(phase)
    if not self.started then
        self.phase = phase
        self.osc = phase
    end
end

function Oscillator:setType(t)
    self.oscType = t
end
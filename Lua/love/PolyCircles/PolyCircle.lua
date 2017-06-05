require "SJTLib"
PolyCircle = class(Figura)

function PolyCircle:init(lados, radius, offAngle, x, y)
    self:super(nil, nil, x, y)
    
    self.lados = lados or 3
    self.radius = radius or 10
    self.offAngle = offAngle or 0
    self:update();
end

function PolyCircle:update()
    
    self:removePoints()
    local angle, offset = 0, 2*math.pi/self.lados;
    
    if self.lados%2==1 then
        angle = math.pi/2 + self.offAngle;
    else
        angle = math.pi - offset/2 + self.offAngle;
    end
    
    for i=1,self.lados do
        self:addPoint(self:polarToCartesian(angle))
        
        angle = angle - offset;
    end
end

function PolyCircle:toString()
    return "PolyCircle"
end

function PolyCircle:polarToCartesian(angle)
    return Point(self.radius*math.cos(angle), self.radius*math.sin(angle))
end

function PolyCircle:rotate(angle)
    self.offAngle = self.offAngle + angle
    
    --[[
    if self.offAngle >= 2*math.pi then
        self.offAngle = self.offAngle - 2*math.pi;
    end
    --]]
    
    self:update()
end

function PolyCircle:getOffAngle()
    return self.offAngle
end
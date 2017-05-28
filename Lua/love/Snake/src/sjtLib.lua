graphics = love.graphics
window = love.window

-- ################################ CLASSES ################################


-- ############################ RECTANGLE CLASS ############################
    
    Rect = {} 
    Rect.__index = Rect 
    function Rect.new(ancho, alto, withBorder)
        local self = setmetatable({}, Rect)
        self.lineWidth = 2
        self.ancho = ancho
        self.alto = alto
        self.divX = self.ancho/59
        self.divY = self.alto/59
        self.centerX = self.ancho/2
        self.centerY = self.alto/2
        
        self.color = {255, 255, 255, 255}
        self.gridColor = {110, 110, 110, 255}
        self.lineColor = self.color
        
        self.withBorder = withBorder
        self.withGrid = false
        
        return self
    end
    
    function Rect.newSquare(lado, withBorder)
        local self = setmetatable({}, Rect)
        self.lineWidth = 2
        self.ancho = lado
        self.alto = lado
        self.centerX = lado/2
        self.centerY = lado/2
        self.divX = lado/59
        self.divY = lado/59
        
        self.color = {255,255,255,255}
        self.gridColor = {123, 123, 123, 255}
        self.lineColor = self.color
        
        self.withBorder = withBorder
        self.withGrid = false
        
        return self
    end
    
    function Rect.getCenterX(self, x) 
        return (x - self.centerX)
    end
    
    function Rect.getCenterY(self, y)
        return (y - self.centerY)
    end
    
    function Rect.getDimensions(self)
        return self.ancho, self.alto
    end
    
    function Rect.getLimits(self, x, y)
        return (x - self.centerX), (x + self.centerX), (y - self.centerY), (y + self.centerY)
    end
    
    function Rect.setColor(self, r, g, b, a)
        self.color = {r, g, b, a}
    end
    
    function Rect.showGrid(self, withGrid)
        self.withGrid = withGrid
    end
    
    function Rect.setLineColor(self, r, g, b, a)
        self.lineColor = {r, g, b, a}
    end
    function Rect.setGridColor(self, r, g, b, a)
        self.gridColor = {r, g, b, a}
    end
    
    function Rect.getColor(self)
        return self.color
    end
    
    function Rect.setLineWidth(self, width)
        self.lineWidth= width
    end
    
    function Rect.getLineWidth(self)
        return self.lineWidth
    end
    
    function Rect.draw(self, x, y)
        graphics.setColor(self.color)
        graphics.rectangle("fill", x, y, self.ancho, self.alto)
        if self.withGrid then
            graphics.setColor(self.gridColor)
            graphics.setLineWidth(1)
            for i=1, (self.ancho + self.lineWidth)/self.divX-1 do
                graphics.line(i * self.divX + x + self.lineWidth, y + self.lineWidth, i * self.divX + x + self.lineWidth, self.alto + y + self.lineWidth)
            end
            for i=1, (self.alto + self.lineWidth)/self.divY-1 do
                graphics.line(x + self.lineWidth, i * self.divY + y + self.lineWidth, self.ancho + x + self.lineWidth, i * self.divY + y + self.lineWidth)
            end
        end
        if self.withBorder then
            graphics.setLineWidth(self.lineWidth)
            graphics.setColor(self.lineColor)
            graphics.rectangle("line", x, y, self.ancho + self.lineWidth , self.alto + self.lineWidth)
        end
    end
    
-- ###############################  END  ###############################


-- ############################ LABEL CLASS ############################

    Label = {}
    Label.__index = Label 
    function Label.new(txt)
        local self = setmetatable({}, Label)
        self.color = {255, 255, 255, 255}
        self.txt = txt
        self.font = 45
        return self
    end
    
    function Label.setFont(self, font)
        self.font = font
    end
    
    function Label.getFont(self)
        return self.font
    end

    function Label.setColor(self, r, g, b, a)
        self.color = {r, g, b, a}
    end
    
    function Label.getColor(self)
        return self.color
    end
    
    
    function Label.draw(self, x, y)
        graphics.setFont(self.font)
        graphics.setColor(self.color)
        graphics.print(self.txt, x, y)
    end
-- ################################ END ################################
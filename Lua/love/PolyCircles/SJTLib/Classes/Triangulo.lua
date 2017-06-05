Triangulo = class(Figura)


--[[
            /\
           /  \
        c /    \ b
         /      \
        /        \
       X----------+
  (x,y)      a
  
  
  
                        +  
            C     +    /
             +        / B   
         +           /
     +--------------- 
             A
             
             
## ##########
             
             
            +  
      B   + |                  |\
        +   | Q          +=====+ \       B^2 = P^2 + Q^2
      +     |            +=====+ /
    +       |                  |/
  +---------+
       P
       
       
## ##########
       
       
            +  
      C   + |                  |\
        +   | Q          +=====+ \       C^2 = (A + P)^2 + Q^2
      +     |            +=====+ /
    +       |                  |/        C^2 = A^2 + 2AP + P^2 + Q^2 
  +---------+
    (A + P)
    
## #########
    
    C^2 = A^2 + 2AP + P^2 + Q^2
    
    C^2 = A^2 + 2AP +    B^2
    
    C^2 - A^2 - B^2 = 2AP
    
    P = (C^2 - A^2 - B^2)/2A
    
# #########
    
    C^2 = (A + P)^2 + Q^2
    
    Q^2 = C^2 - (A + P)^2
    
    Q =  sqrt[C^2 - (A + P)^2]
]]

function Triangulo:init(a,b,c,x,y)
  self:super(nil, nil, x, y)
  self.a = a or 400 -- Length of A
  self.b = b or 300 -- Length of B
  self.c = c or 250 -- Length of C 
  
  self:setOriginMode("center")
  
end
function Triangulo:setOriginMode(m)
  self.originMode = m
  self:update()
end

function Triangulo:getOriginMode()
  return self.originMode
end

function Triangulo:setABC(a,b,c)
  self.a = a or self.a
  self.b = b or self.b
  self.c = c or self.c
  self:update()
end

function Triangulo:update()
  -- #### SEE ABOVE ####
  p = (self.c^2 - self.a^2 - self.b^2)/(2*self.a)
  
  q = math.sqrt(self.c^2 - (self.a + p)^2)
  
  bariX, bariY = 0, 0
  if self.originMode == "center" then
    bariX = (2*self.a + p)/3
    bariY = q/3
  end
  self:removePoints()
  self:addPoints({
                  Point(-bariX,-bariY), -- Point between AC (x,y)
                  Point(self.a + p-bariX, q-bariY), -- Point between BC(x+a+p, y+q)
                  Point(self.a-bariX, -bariY) -- Point between AB (x+a,y)
                  })
end

function Triangulo:toString()
  return "Triangulo"
end
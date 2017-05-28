-- Matrix

require "Node"
Matrix = class()

function Matrix:init()
    self.solved = false
    self.srtNode = nil -- Punto de inicio
    self.endNode = nil -- Punto de llegada
    self.curNode = nil -- Nodo Actual (A*)
    self.tchNode = nil -- Nodo anterior
    self.pTchNode = nil -- Nodo antes del anterior
    self.passThrough = false -- Pasar a traves de los nodos Inicio y/o Fin
    self.waller = true -- Modo "Crear Paredes"
    self.nodeList = {} -- Nodos Abiertos
    self.mtx = {}
    for x=1,cX do
        self.mtx[x] = {} -- Crear nueva fila
        for y=1, cY do
            self.mtx[x][y] = nil
        end
    end
    
    -- Llenar la matriz con Nodos nuevos!! =D
    self:fill()
    
    -- Colocar nodos Inicio y fin;
    -- es math.ceil debido a que si es un numero impar (p. ej 15)
    -- la mitad es 7.5, y el nodo en la mitad sera el 8
    self.mtx[1][math.ceil(cY/2)]:setType(Types.START)
    self.srtNode = self.mtx[1][math.ceil(cY/2)]
    self.mtx[cX][math.ceil(cY/2)]:setType(Types.END)
    self.endNode = self.mtx[cX][math.ceil(cY/2)]
    self.calculated = false
end


function Matrix:update()
    for x=1, cX do
        for y=1, cY  do
            self.mtx[x][y]:update()
        end
    end
end


function Matrix:draw()
  for x=1, cX do
    for y=1, cY do
      self.mtx[x][y]:draw()
    end
  end
end


function Matrix:touched(t)
    self.mouse = t
    -- Deteccion del Nodo que se esta tocando
    local x, y, detected = 0, 0, false
        
    -- Detectar la Posicion en X del Nodo
    for i=1,cX do
            
        -- Posicion en Y
        for j=1,cY do
            detected = self.mtx[i][j]:isBeingTouched(t)
            if detected then
                y = j
                break
            end
        end
        if detected then
            x = i
            break
        end
    end
        
    --Aplicar procedimientos con el Nodo que se esta tocando
    if detected then
        self:processNode(self.mtx[x][y])
    end
end


-- ==== Matrix Functions ====

function Matrix:clear()
    for x=1, cX do
        for y=1, cY do
            if self.mtx[x][y]:getType() ~= Types.START and
               self.mtx[x][y]:getType() ~= Types.END   and
               self.mtx[x][y]:getType() ~= Types.WALL then
                    self.mtx[x][y]:setType(Types.NONE)
            end
        end
    end
end


function Matrix:fill()
    for x=1,cX do
        for y=1, cY do
            if not self.mtx[x][y] then
                self.mtx[x][y] = Node(x, y)
            end
        end
    end
end


function Matrix:processNode(n)
    
    -- La interaccion solo ocurre cuando NO se termina el toque...
    if not self.mouse.ENDED then
        
        -- Determinar si queremos crear una pared (si el toque esta sobre un Nodo vacio)
        -- cuando el toque comienza.
        if self.mouse.BEGAN then
            self.waller = n:getType() == Types.NONE
            if n:getType() == Types.START or n:getType() == Types.END then
                self.movingNode = true
            end
        end
    
        -- Si se cambia de estado en otro Nodo del que hemos tocado antes
        if not n:is(self.tchNode) then
            
            -- Si hemos tocado un nodo antes
            if self.tchNode then
                -- Pasar de largo si estamos sobre el Nodo Inicio/Fin
                if (n:getType() == Types.START or n:getType() == Types.END) and self.tchNode:isNeighbour(n)
                and self.mouse.MOVING and not self.passThrough and not self.movingNode then
                    self.passThrough = true
                end
            
                -- Mover el Nodo Inicio solo si el toque se esta moviendo
                -- y si no estabamos creando/borrando paredes
                if self.tchNode:getType() == Types.START and self.mouse.MOVING then
                    if not self.passThrough then
                        -- Guardar la clase del Nodo, para luego recuperarlo
                        n:saveType()
                        n:setType(Types.START)
                        self.srtNode = n
                        self.tchNode:setType(self.tchNode:loadType()) -- Recuperar la clase del Nodo anterior
                    else
                        -- Crear/Borrar pared; ya no estamos sobre el Nodo Inicio
                        if self.waller then
                            n:setType(Types.WALL)
                        else
                            n:setType(Types.NONE)
                        end
                        self.passThrough = false
                    end
                
                -- Lo mismo que arriba
                elseif self.tchNode:getType() == Types.END and self.mouse.MOVING then
                    if not self.passThrough then
                        n:saveType()
                        n:setType(Types.END)
                        self.endNode = n
                        self.tchNode:setType(self.tchNode:loadType()) -- Recuperar la clase del Nodo anterior
                    else
                        if self.waller then
                            n:setType(Types.WALL)
                        else
                            n:setType(Types.NONE)
                        end
                        self.passThrough = false
                    end
            
                
                -- Crear pared o borrarla, si estamos tocando un Nodo vacio o una pared
                elseif not (self.tchNode:getType() == Types.EXPLORED or self.tchNode == Types.EXPLORING) then
                    if n:getType() ~= Types.START and n:getType() ~= Types.END then
                        if self.waller then
                            n:setType(Types.WALL)
                        else
                            n:setType(Types.NONE)
                        end
                    end
                end
            -- Si es el primer Nodo que tocamos y NO es el de Inicio o Fin, crear o borrar la pared
            else
                if n:getType() ~= Types.START and n:getType() ~= Types.END then
                    if self.waller then
                        n:setType(Types.WALL)
                    else
                        n:setType(Types.NONE)
                    end
                end
            end
        
        -- Si el toque esta en el mismo Nodo
        else
        
            -- y si empezo en un Nodo diferente al de Inicio o Fin, crear pared
            if self.mouse.BEGAN then
                if n:getType() ~= Types.START and n:getType() ~= Types.END then
                    if self.waller then
                        self.tchNode:setType(Types.WALL)
                    else
                        self.tchNode:setType(Types.NONE)
                    end
                end
            end
        end
        self.pTchNode = self.tchNode
        self.tchNode = n
    elseif self.movingNode then
        
        -- Poner savedType como NONE para no crear duplicados
        if self.srtNode:is(self.endNode) then
          n:specialNode()
        end
        self:resetST()
        self.movingNode = false
    end
end





-- Remover Paredes
function Matrix:removeW()
    for x=1, cX do
        for y=1, cY do
            if self.mtx[x][y]:getType() == Types.WALL then
                    self.mtx[x][y]:setType(Types.NONE)
            end
        end
    end
end


function Matrix:resetST()
    for x=1, cX do
        for y=1, cY  do
            self.mtx[x][y]:resetST()
        end
    end
end


function Matrix:resumeOrPause()
    
end


function Matrix:undo()
    -- Si hemos tocado dos o mas Nodos
    if self.pTchNode then
        -- Si el Nodo anterior que tocamos fue el de Inicio o Fin hacemos el nodo tras anterior Inicio o Fin
        if self.tchNode:getType() == Types.START or self.tchNode:getType() == Types.END then
            self.pTchNode:setType(self.tchNode:getType())
        end
    end
    -- Deshacer borrado o creacion de pared
    if self.tchNode:getType() == Types.NONE then
        self.tchNode:setType(Types.WALL)
    elseif self.tchNode:getType() == Types.WALL then
        self.tchNode:setType(Types.NONE)
    end
    self.tchNode = nil
end


-- ==== A* Algorithm Functions ====

function Matrix:next()
  if not self.solved then
    if not self.calculated then
      self:calculateAll()
    end
    if not self.curNode then
      self.curNode = self.srtNode
    else
      self.curNode = self.nodeList[1]
    end
    self:analyzeNodes()
  else
    local n = self.curNode
    while n do
      n:setType(Types.PATH)
      n = n:getParent()
      if n:is(self.srtNode) then
        break
      end
    end
  end
end


function Matrix:analyzeNodes()
  self:removeFromList(self.curNode)
  local neigh = self.curNode:getNeighbours()
  for j,p in pairs(neigh) do
    v = self.mtx[p.x][p.y]
    if v:getType() ~= Types.WALL then
      if v:getType() == Types.END then
        self.solved = true
        break
      else
        v:setType(Types.EXPLORING)
        if v:isOpen() then
          if (self.curNode:getParent():getG(self.curNode) + v:getG(self.curNode)) < (v:getParent():getG(v)) then
            v:setParent(self.curNode)
          end
        else
          v:setParent(self.curNode)
          self:addToList(v)
        end
        v:setType(Types.EXPLORED)
      end
    end
  end
end

function Matrix:calculateAll()
  for x=1, cX do
    for y=1, cY do
      nd = self.mtx[x][y]
      if nd:getType() ~= Types.WALL then
        nd:calcH(self.endNode)
      end
    end
  end
  self.calculated = true
end

function Matrix:addToList(n)
  n:open()
  table.insert(self.nodeList,n)
end


function Matrix:removeFromList(n)
  n:close()
  if #self.nodeList ~= 0 then
    local i = 0
    for k,v in pairs(self.nodeList) do
      i = i + 1
      if n:is(v) then
        table.remove(self.nodeList, i)
        break
      end
    end
  end
end
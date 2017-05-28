--- See LUA Inheritance Tutorials

function class(baseClass)
  newClass =  {}
  newClass.__index = newClass
  setmetatable(newClass,
      { __call =
        function (cls, ...)
          local self = setmetatable({}, cls)
          
          bC = getmetatable(cls).__index
          s = self.toString
          if bC then -- si tiene baseClass
            if self.toString() == "Base Object" then -- y si tiene el tS por defecto,
              s = bC.toString -- hereda el tS de la baseClass
            end
          end
          
          getmetatable(self).__tostring = s
          
          local i = 0
          self.super = function (...)
            i = i + 1
            fC = self
            for a=1,i do
              fC = fC:superClass()
            end
            fC.init(...)
          end
          self:init(...)
          return self
        end,})
  if baseClass then
    getmetatable(newClass).__index = baseClass
  end
  
  function newClass:init()
  end
  
  function newClass:class()
    return newClass
  end

  function newClass:superClass()
      return baseClass
  end
  
  -- Return true if the caller is an instance of theClass
  function newClass:isa( theClass )
    local b_isa = false

    local cur_class = newClass

    while ( nil ~= cur_class ) and ( false == b_isa ) do
      if cur_class == theClass then
        b_isa = true
      else
        cur_class = cur_class:superClass()
      end
    end

    return b_isa
  end
  
  function newClass:toString()
    return "Base Object"
  end
  
  return newClass
end
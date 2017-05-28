function class(clss)
    cls = {}
    cls.__index = cls
    setmetatable(cls,
    { __index = clss,
      __call = 
        function (c, ...)
            local self = setmetatable({}, c)
            self:init(...)
            return self
        end,
    })
    if clss then
        cls.super =
        function (...)
            clss:init(...)
        end
    end
    return cls
end
Binary = {}

local Memory = class()
local Int = class(Memory)
local Float = class(Memory)

function Memory:init(maxBits)
    self.maxBits = maxBits or 1
end

function Memory:setBits(bits)
    self.bits = bits or "0"
    if self.bits:len() > self.maxBits then
        self.bits = self.bits:sub(-self.maxBits)
    elseif self.bits:len() < INT_BITS then
        for i=1, self.maxBits-n:len() do
            self.num = "0"..self.num
        end
    end
end

--[[

0111 1111   1111 1111   1111 1111   1111 1111         2147483647   // INT_MAX


0000 0000   0000 0000   0000 0000   0000 0000         0


1000 0000   0000 0000   0000 0000   0000 0000         -2147483648  // INT_MIN

1111 1111   1111 1111   1111 1111   1111 1111         -1



---------------------------------------------

0111 1111   1111 1111   1111 1111   1111 1111         -2147483649
--]]


INT_MAX = 2147483647
INT_MIN = -2147483648
INT_BITS = 32 -- 4 Bytes

function Int:init(num)
    self.super(INT_BITS)
    local n = num or 0
    self:setBits(Helper.decimalToBin(math.floor(n)))
end

FLOAT_BITS = 32 -- IEEE754 32Bits
function Float:init(num)
    self.super(FLOAT_BITS)
    local n = num or 0
    self:setBits(Helper.floatToIEEE754_32(num))
end
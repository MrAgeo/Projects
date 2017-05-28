Helper = {}

function Helper.binToDecimal(num)
    assert(type(num) == "string", "The number is not a String!")
    local curN = 0
    local pointIndex = num:find("%.")
    local pInt = num
    if pointIndex then
        pInt = num:sub(1,pointIndex-1)
        pDec = num:sub(pointIndex+1)
        for i=1,pDec:len() do
            curN = curN + 2^(-i)*tonumber(pDec:sub(i,i))
        end
    end
    for i=1, pInt:len() do
        curN = curN + 2^(pInt:len()-i)*tonumber(pInt:sub(i,i))
    end
    return curN
end


function Helper.decimalToBin(n, decimals)
    assert(tonumber(n), "The number is not valid! (got nil)")
    local num = tonumber(n)
    local num2 = num
    local d = (decimals or 6)
    
    if num<0 then
        num = -num
    end
    
    local pInt = math.floor(num)
    local pDec = num - pInt
    local numBin, numDec = "", ""
    
    if pInt ~= 0 then
        while pInt>0 do
            rest=math.fmod(pInt,2)
            numBin= tostring(rest)..numBin
            pInt=(pInt-rest)/2
        end
        if num2<0 then
            numBin = "-"..numBin
        end
    else
        numBin = "0"
    end
    if pDec ~= 0 then
        local decs = 1
        local curN = pDec*2
        while (curN ~= math.floor(curN)) and decs<d do
            numDec = numDec..tostring(math.floor(curN))
            curN = (curN - math.floor(curN))*2
            decs = decs + 1
        end
        numDec = numDec..tostring(math.floor(curN))
    else
        numDec = "0"
    end
    return numBin, numDec
end


function Helper.floatToIEEE754_32(num)
    local sign, exp, frac = "", "", ""
    local n = tostring(num)
    
    if n:sub(1,1) == "-" then
        sign = "1"
        n = n:sub(2)
    else
        sign = "0"
    end
    
    if n == "nan" then
        exp = "11111111"
        frac = "1"
    elseif n == "inf" then
        exp = "11111111"
        frac = "0"
    elseif n == "0" then
        exp = "00000000"
        frac = "0"
    else
        local numBin, numDec = Helper.decimalToBin(n, 23)
        frac = numBin:sub(2)..numDec
        exp = Helper.decimalToBin((numBin:len()-1)+127)
    end
    if frac:len()>23 then
        frac = frac:sub(1,23)
    else
        for i=1, 23-frac:len() do
            frac = frac.."0"
        end
    end
    
    if exp:len()>8 then
        frac = frac:sub(1,8)
    else
        for i=1, 8-exp:len() do
            exp = "0"..exp
        end
    end
    
    return sign..exp..frac
end


function Helper.floatToIEEE754_16(num)
    local sign, exp, frac = "", "", ""
    local n = tostring(num)
    
    if n:sub(1,1) == "-" then
        sign = "1"
        n = n:sub(2)
    else
        sign = "0"
    end
    
    if n == "nan" then
        exp = "11111"
        frac = "0000000001"
    elseif n == "inf" then
        exp = "11111"
        frac = "0000000000"
    elseif n == "0" then
        exp = "00000"
        frac = "0000000000"
    else
        local numBin, numDec = Helper.decimalToBin(n, 10)
        frac = numBin:sub(2)..numDec
        if frac:len()>10 then
            frac = frac:sub(1,10)
        else
            for i=1, 10-frac:len() do
                frac = frac.."0"
            end
        end
        exp = Helper.decimalToBin((numBin:len()-1)+15)
        if exp:len()>5 then
            frac = frac:sub(1,5)
        else
            for i=1, 5-exp:len() do
                exp = "0"..exp
            end
        end
    end
    
    return sign..exp..frac
end

function Helper.separateInBytes(bits)
    local t = {}
    local sign = (bits:gsub(1,1) == "-")
        
    if sign then
        bits = bits:gsub(2)
    end
    bits = bits:reverse()
    local index = 1
    while (1 + (index-1)*8) <= bits:len() do
        table.insert(t,1, bits:sub(1 + (index-1)*8, index*8):reverse())
        index = index + 1
    end
    if t[1]:len()<8 then
        for i=1, 8-t[1]:len() do
            t[1] = "0"..t[1]
        end
    end
    return t
end


function Helper.castFloatToInt(num)
    return Helper.binToDecimal(Helper.floatToIEEE754_32(num))
end
numlu = {}

function numlu.toNumber(s)
  local num = tonumber(s)
  local s2 = ""
  local numEncontrado = false
  if not num then
    for curIndex=1, string.len(s) do
      char = string.sub(s,curIndex,curIndex)
      for _,n in ipairs({"0", "1", "2", "3", "4", "5", "6", "7", "8", "9"}) do
          if (char == "-" and curIndex == 1) or (char == n) then
            s2 = s2..char
            numEncontrado = true
            break
          end
      end
      if curIndex == string.len(s) and not numEncontrado then
        s2 = nil
      end
    end
    num = tonumber(s2)
  end
  return num, numEncontrado
end
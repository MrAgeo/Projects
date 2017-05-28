
-- ######## TABLES ########

ColorMan = {}

function ColorMan.negative(c)
  return Color(math.abs(c.r-255), math.abs(c.g-255), math.abs(c.b-255), c.a)
end
function ColorMan.RGBgray(num, alpha)
  return Color(num, num, num, alpha)
end

Colors = {}
Colors.BLACK = ColorMan.RGBgray(0)
Colors.BLUE = Color(0,0,255)
Colors.GRAY = ColorMan.RGBgray(127)
Colors.GREEN = Color(0,255,0)
Colors.RED = Color(255,0,0)
Colors.WHITE = ColorMan.RGBgray(255)

-- ######## END TABLES ########
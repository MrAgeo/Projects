local current_folder = (...):gsub('%.[^%.]+$', '') .. ".postInit"
local cls = {"Binary", "ColorMan", "Helper"}
local function req()
  for k,v in pairs(cls) do
    require(current_folder .."."..v)
  end
end
req()
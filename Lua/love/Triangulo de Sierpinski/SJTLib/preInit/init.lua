local current_folder = (...):gsub('%.[^%.]+$', '') .. ".preInit"
local cls = {"Window", "Mouse", "Keys", "Class"}
local function req()
  for k,v in pairs(cls) do
    require(current_folder .."."..v)
  end
end
req()
-- ### SJTLib_SoundLib Init File ###
local current_folder = (...):gsub('%.[^%.]+$', '') .. ".SoundLib"
local cls = {"FileIO", "Oscillator", "SoundEncoder", "SoundFile"}
local function req()
  for k,v in pairs(cls) do
    require(current_folder .."."..v)
  end
end
req()
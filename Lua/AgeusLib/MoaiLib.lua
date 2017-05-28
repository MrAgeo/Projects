require "Class"

local Moai = class()
--local MoaiWindow = class()
moai = Moai()

function Moai:init()
    self.windows = {}
    self.screenHeight = MOAIEnvironment.screenHeight or 600
    self.screenWidth = MOAIEnvironment.screenWidth or 800
end

function Moai:openWindow(title)
    MOAISim.openWindow(title, self.screenWidth, self.screenHeight)
end
    
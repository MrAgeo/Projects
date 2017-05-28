SoundFile = {}
local SF = class()

function SoundFile.newFromRaw(data)
    return SF(data)
end

function SF:init(data)
    self.rawData = ""
end
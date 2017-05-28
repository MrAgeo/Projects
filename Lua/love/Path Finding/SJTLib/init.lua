__SJTLibVersion = "12-03-2017_1"

local current_folder = (...):gsub('%.init$', '')
require(current_folder .. ".preInit")
require(current_folder .. ".Classes")
require(current_folder .. ".postInit")

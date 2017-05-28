graphics = love.graphics
window = love.window
window.width, window.height = graphics.getDimensions()
closeLove2d = love.event.quit


local oldFullscreen = window.setFullscreen

function window.setFullscreen(bool,mode)
  oldFullscreen(bool,mode or "desktop")
  window.width, window.height = graphics.getDimensions()
end

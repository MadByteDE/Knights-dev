
local GameScene = Game.Scene()

function GameScene:init()
end


function GameScene:update(dt)
end


function GameScene:draw()
  local screenW, screenH = Game.screen:getDimensions()
  Game.printf(_VERSION, 0, 0, screenW, "center", {.075, .075, .075, 1})
end


function GameScene:keypressed(key)
  if key == "escape" then love.event.quit() end
end


function GameScene:mousepressed(x, y, button)

end

return GameScene

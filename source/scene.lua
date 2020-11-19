

local Scene = Game.Class()


function Scene:init()
end


function Scene:update(dt)
  self:logic(dt)
end


function Scene:draw()
  self:render()
  -- Assets.print("FPS: "..love.timer.getFPS(), 3, 30)
  -- Assets.print("MEM: "..math.floor(collectgarbage("count")).."kb", 3, 40)
end

function Scene:logic(dt) end

function Scene:render() end

function Scene:mousepressed(...)
end

function Scene:mousereleased(...)
end

function Scene:keypressed(...)end

function Scene:keyreleased(...)end

return Scene

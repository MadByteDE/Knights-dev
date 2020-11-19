
local Game = {}

love.graphics.setDefaultFilter("nearest", "nearest")
local Assets = require("source.assets")
love.graphics.setFont(Assets.fonts["normal"])


local function initModules()
  -- Modules --
  Game.Class = require("source.class")
  Game.Container = require("source.conta")
  Game.Scene = require("source.scene")
  Game.Object = require("source.object")
  Game.screen = require("source.screen")
end


local function initFunctions()
  -- Functions --
  Game.printf = function(text, x, y, w, mode, color)
    color = color or {1, 1, 1, 1}
    love.graphics.setColor(color)
    love.graphics.printf(text, x or 0, y or 0, w or text:getLineWidth(), mode or "center")
    love.graphics.setColor(1, 1, 1, 1)
  end
  Game.print = function(text, x, y, color)
    color = color or {1, 1, 1, 1}
    love.graphics.setColor(color)
    love.graphics.print(text, x, y)
    love.graphics.setColor(1, 1, 1, 1)
  end
end


local function initScenes()
  -- Scenes --
  Game.gameScene = require("source.scenes.gameScene")
end


local function initMouse()
  -- Mouse --
  Game.mouse = {}
  Game.mouse.dimension = {w=1, h=1}
  Game.mouse.setPosition = function(self, x, y)
    local scale = Game.screen.scale
    love.mouse.setPosition((x or 0)*scale, (y or 0)*scale)
  end
  Game.mouse.getPosition = function(self)
    local scale = Game.screen.scale
    local mx, my = love.mouse.getPosition()
    return mx/scale, my/scale
  end
end


------------------------------------------
-- INIT --
------------------------------------------
function Game:init()
  initModules()
  initFunctions()
  initMouse()
  self.screen:init(256, 256, 2)
  local screenW, screenH = Game.screen:getDimensions()
  self.mouse:setPosition(screenW/2, screenH/2)

  -- Scenes --
  initScenes()
  self.currentScene = self.gameScene
  self.currentScene:init()
end


local printf = function(text, x, y, w, mode, color)
  color = color or {1, 1, 1, 1}
  love.graphics.setColor(color)
  love.graphics.printf(text, x or 0, y or 0, w or text:getLineWidth(), mode or "center")
  love.graphics.setColor(1, 1, 1, 1)
end


------------------------------------------
-- UPDATE --
------------------------------------------
function Game:update(dt)
  self.currentScene:update(dt)
end


------------------------------------------
-- DRAW --
------------------------------------------
function Game:draw()
  self.screen:set()
  self.currentScene:draw()
  self.screen:unset()
end


function Game:keypressed(...)
  self.currentScene:keypressed(...)
end


function Game:mousepressed(...)
  self.currentScene:mousepressed(...)
end

return Game

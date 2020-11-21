
local Game = {
  log_string = "",

  fonts = {
    ["normal"] = love.graphics.newFont("assets/fonts/tinypixels.ttf", 8),},

  colors = {
    ["black"] = {0, 0, 0},
    ["white"] = {1, 1, 1},
    ["red"] = {1, .35, .35},
    ["dark_red"] = {.65, 0, 0},
    ["green"] = {.35, 1, .35},
    ["dark_green"] = {0, .65, 0},
    ["blue"] = {.35, .35, 1},
    ["dark_blue"] = {0, 0, .65},
    ["aqua"] = {.35, 1, 1},
    ["dark_aqua"] = {0, .65, .65},
    ["purple"] = {1, .35, 1},
    ["dark_purple"] = {.65, 0, .65},
    ["gray"] = {.65, .65, .65},
    ["dark_gray"] = {.35, .35, .35},
    ["yellow"] = {1, 1, .35},
    ["gold"] = {1, .65, 0},},

  images      = {},
  sounds      = {},
  grids       = {},
  animations  = {},
  tiles       = {},
}


-- Mouse --
local function createMouseObject()
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
  -- Modules --
  self.Class = require("source.lib.class")
  self.Container = require("source.conta")
  self.Scene = require("source.scene")
  self.Object = require("source.object")
  self.Anim8 = require("source.lib.anim8")
  self.screen = require("source.screen")

  -- Scenes --
  self.gameScene = require("source.scenes.gameScene")

  -- Set default font --
  love.graphics.setFont(Game.fonts["normal"])

  -- Init screen --
  self.screen:init(SCREEN_WIDTH or 150, SCREEN_HEIGHT or 150, SCALE or 2)
  local screenW, screenH = Game.screen:getDimensions()

  -- Init mouse
  createMouseObject()
  self.mouse:setPosition(screenW/2, screenH/2)

  -- Scenes --
  self.currentScene = self.gameScene
  self.currentScene:init()
  self.log("i", "Initialized game successfully...")
end


-- General --
function Game.log(type,  msg)
  local line
  if type == "w" then line = "[Warn] "..msg
  elseif type == "i" then line = "[Info] "..msg
  elseif type == "e" then line = "[Err] "..msg end
  print(line)
  Game.log_string = Game.log_string.."\n"..line
end


------------------------------------------
-- GAME METHODS / FUNCTIONS --
------------------------------------------

-- Print text --
function Game.printf(text, x, y, w, mode, color)
  color = color or {1, 1, 1, 1}
  love.graphics.setColor(color)
  love.graphics.printf(text, x or 0, y or 0, w or text:getLineWidth(), mode or "center")
  love.graphics.setColor(1, 1, 1, 1)
end


function Game.print(text, x, y, color)
  color = color or {1, 1, 1, 1}
  love.graphics.setColor(color)
  love.graphics.print(text, x, y)
  love.graphics.setColor(1, 1, 1, 1)
end


-- Sounds / Music --
function Game.playSound(name, vol, loop)
  local source = Game.sounds[name]
  local vol = vol or 1
  if vol then source:setVolume(vol) end
  if source:isPlaying() then source:stop() end
  source:play()
  if loop ~= nil then source:setLooping(loop) end
end


function Game.cloneSound(name)
  return Game.sounds[name]:clone()
end


-- Images / Sprites --
function Game.getImage(name)
  return Game.images[name]
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


------------------------------------------
-- CALLBACKS --
------------------------------------------

function Game:keypressed(...)
  self.currentScene:keypressed(...)
end


function Game:mousepressed(...)
  self.currentScene:mousepressed(...)
end


function Game:quit()
  -- Create a log file in the game's save directory
  self.log("i", "Creating log file at "..love.filesystem.getSaveDirectory())
  local log_file = love.filesystem.newFile("latest_log.txt", "w")
  log_file:write(self.log_string)
  log_file:close()
end

return Game


_VERSION      = 'Knights-dev v0.0.1'
_URL          = 'https://github.com/MadByteDE/knights-dev'
_DESCRIPTION  = '2D vs/coop dungeon-crawler for 1-4 players'
_LICENSE      = [[ ]]

-- Options
DEBUG_MODE    = true
SCREEN_WIDTH  = 240
SCREEN_HEIGHT = 180
SCALE         = 4

io.stdout:setvbuf("no")
love.graphics.setDefaultFilter("nearest", "nearest")

Game = require('source.game')

function love.load(...) Game:init(...) end
function love.update(dt) Game:update(dt) end
function love.draw() Game:draw() end
function love.keypressed(...) Game:keypressed(...) end
function love.mousepressed(...) Game:mousepressed(...) end
function love.quit(...) Game:quit(...) end
-- function love.focus(...) Game:focus(...) end


_VERSION     = 'Knights-dev v0.0.1'
_URL         = 'https://github.com/MadByteDE/knights'
_DESCRIPTION = '2D vs/coop dungeon-crawler for 1-4 players'
_LICENSE     = [[ ]]


Game = require('source.game')
io.stdout:setvbuf("no")

function love.load() Game:init() end
function love.update(dt) Game:update(dt) end
function love.draw() Game:draw() end
function love.keypressed(...) Game:keypressed(...) end
function love.mousepressed(...) Game:mousepressed(...) end
-- function love.focus(...) Game:focus(...) end

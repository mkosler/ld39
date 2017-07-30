local Gamestate = require 'lib.hump.gamestate'

local GameOver = {}

function GameOver:enter()
    ASSETS['game-over-audio']:play()
end

function GameOver:draw()
    love.graphics.push()
    love.graphics.origin()
    love.graphics.setFont(ASSETS['font12-bold'])
    love.graphics.printf('You did it!', 0, love.graphics.getHeight() / 2, love.graphics.getWidth(), 'center')
    love.graphics.pop()
end

return GameOver
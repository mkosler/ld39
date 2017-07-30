local Gamestate = require 'lib.hump.gamestate'

local Title = {}

function Title:init()
end

function Title:enter(prev, ...)
end

function Title:leave()
end

function Title:update(dt)
end

function Title:draw()
    love.graphics.push()
    love.graphics.origin()
    love.graphics.print('Press any key...')
    love.graphics.pop()
end

function Title:keypressed(key, scancode, isRepeat)
    Gamestate.switch(LevelSelect)
end

function Title:keyreleased(key, scancode, isRepeat)
end

return Title
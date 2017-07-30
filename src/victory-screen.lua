local Gamestate = require 'lib.hump.gamestate'

local Victory = {}

function Victory:enter(prev, n)
    self.prev = prev
    self.n = n
end

function Victory:leave()
    self.prev:leave()
end

function Victory:draw()
    self.prev:draw()

    love.graphics.push('all')
    love.graphics.origin()
    love.graphics.setColor(255, 255, 255)
    love.graphics.print('Finished! Press any key to continue...')
    love.graphics.pop()
end

function Victory:keypressed(key, scancode, isRepeat)
    Gamestate.switch(LevelSelect, self.n)
end

return Victory
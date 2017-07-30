local Gamestate = require 'lib.hump.gamestate'
local Timer = require 'lib.hump.timer'

local Title = {}

function Title:init()
end

function Title:enter(prev, ...)
    self.visible = true
    self.handle = Timer.every(0.75, function ()
        self.visible = not self.visible
    end)
end

function Title:leave()
    Timer.cancel(self.handle)
end

function Title:update(dt)
end

function Title:draw()
    love.graphics.setColor(255, 255, 255)
    love.graphics.draw(ASSETS['title'])

    love.graphics.push()
    love.graphics.origin()
    love.graphics.setColor(99, 99, 99)
    love.graphics.setFont(ASSETS['font12-bold'])
    love.graphics.print('River City Press', 30, 60)
    love.graphics.setFont(ASSETS['font8'])
    love.graphics.printf('POWER-UP SHORTAGE LEAVES HEROES LOOKING FOR ANSWERS', 25, 150, 450, 'center')
    if self.visible then
        love.graphics.printf('Press any key to start...', 25, 270, 450, 'center')
    end
    love.graphics.pop()
end

function Title:keypressed(key, scancode, isRepeat)
    Gamestate.switch(LevelSelect)
end

function Title:keyreleased(key, scancode, isRepeat)
end

return Title
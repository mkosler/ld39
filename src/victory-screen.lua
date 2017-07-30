local Gamestate = require 'lib.hump.gamestate'
local Timer = require 'lib.hump.timer'
local Vector = require 'lib.hump.vector'

local Victory = {}

function Victory:enter(prev, n, packageCount)
    self.prev = prev
    self.n = n
    self.packageCount = packageCount
    self.invoicePosition = Vector(0, 134)

    Timer.script(function (wait)
        if self.prev.camera.x ~= 0 then
            Timer.tween(0.5, self.prev.camera, { x = 0 }, 'out-quad')
            wait(0.5)
        end
        Timer.tween(0.2, self.invoicePosition, { y = 60 })
        wait(0.2)
        self.showApproved = true
        ASSETS['finish-audio']:play()
        wait(2)
        Gamestate.switch(LevelSelect, self.n)
    end)
end

function Victory:leave()
    self.prev:leave()
end

function Victory:draw()
    self.prev:draw()

    love.graphics.push()
    love.graphics.translate(self.invoicePosition:unpack())
    love.graphics.setColor(255, 255, 255)
    for i = self.packageCount - 1, 0, -1 do
        love.graphics.draw(ASSETS['large-invoice'], i, -i)
    end
    if self.showApproved then
        love.graphics.draw(ASSETS['approved'], 80, 20)
    end
    love.graphics.pop()
end

return Victory
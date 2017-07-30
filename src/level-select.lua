local Button = require 'src.button'
local Gamestate = require 'lib.hump.gamestate'
local Utils = require 'src.utils'
local Vector = require 'lib.hump.vector'
local Signal = require 'lib.hump.signal'
local Package = require 'src.package'

local LevelSelect = {}

function LevelSelect:init()
    self.completedLevels = {}
end

function LevelSelect:enter(prev, n)
    self.n = n
    self.levels = {
        {
            packages = {
                Package({
                    { 0, 0, 1, 0 },
                    { 1, 1, 1, 1 },
                    { 1, 1, 1, 0 }
                }, { T = 1, J = 1 }, Vector(40, 48)),
                Package({
                    { 0, 0, 1, 0 },
                    { 1, 1, 1, 1 },
                    { 1, 1, 1, 0 }
                }, { T = 1, J = 1 }, Vector(128 + 40, 48))
            }
        }
    }

    if n then
        self.completedLevels[n] = true
    end

    self.buttons = {
        Button(Vector(16, 32), ASSETS['1'], function ()
            Gamestate.switch(Play, 1, unpack(self.levels[1].packages))
        end),
        Button(Vector(80, 32), ASSETS['2'], function ()
            Gamestate.switch(Play, 2, unpack(self.levels[1].packages))
        end),
        Button(Vector(16, 80), ASSETS['3'], function ()
            Gamestate.switch(Play, 3, unpack(self.levels[1].packages))
        end),
        Button(Vector(80, 80), ASSETS['4'], function ()
            Gamestate.switch(Play, 4, unpack(self.levels[1].packages))
        end),
    }
    self.buttons[1].hoverImage = ASSETS['1-hover']
    self.buttons[2].hoverImage = ASSETS['2-hover']
    self.buttons[3].hoverImage = ASSETS['3-hover']
    self.buttons[4].hoverImage = ASSETS['4-hover']
end

function LevelSelect:leave()
    Signal.clear('click')
end

function LevelSelect:update(dt)
    Utils.map(self.buttons, 'update', dt)
end

function LevelSelect:draw()
    love.graphics.push()
    love.graphics.origin()
    love.graphics.setFont(ASSETS['font12-bold'])
    love.graphics.setColor(0, 0, 0)
    love.graphics.print('Level Select', 105, 30)
    love.graphics.setColor(255, 255, 255)
    love.graphics.print('Level Select', 100, 25)
    love.graphics.pop()

    for i,b in pairs(self.buttons) do
        if self.completedLevels[i] then
            love.graphics.setColor(255, 255, 255, 100)
        else
            love.graphics.setColor(255, 255, 255)
        end

        b:draw()
    end
end

function LevelSelect:mousepressed(x, y, button, isTouch)
    Signal.emit('click', x, y, button)
end

function LevelSelect:keypressed(key, scancode, isRepeat)
end

function LevelSelect:keyreleased(key, scancode, isRepeat)
end

return LevelSelect
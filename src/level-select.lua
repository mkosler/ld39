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
    print('Entering level select...')
    self.n = n
    self.levels = {
        {
            packages = {
                Package({
                    { 0, 0, 1, 0 },
                    { 1, 1, 1, 1 },
                    { 1, 1, 1, 0 }
                }, { T = 1, J = 1 }, Vector(48, 48))
            }
        }
    }

    if n then
        self.completedLevels[n] = true
    end

    self.buttons = {
        Button(Vector(16, 16), ASSETS[1], nil, function ()
            Gamestate.switch(Play, 1, unpack(self.levels[1].packages))
        end),
    }
end

function LevelSelect:leave()
    Signal.clear('click')
end

function LevelSelect:update(dt)
    Utils.map(self.buttons, 'update', dt)
end

function LevelSelect:draw()
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
local Tetromino = require 'src.tetromino'
local Package = require 'src.package'
local Vector = require 'lib.hump.vector'
local Utils = require 'src.utils'

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
    for _,v in pairs(self.entities) do
        v:draw()
    end
end

function Title:keypressed(key, scancode, isRepeat)
end

function Title:keyreleased(key, scancode, isRepeat)
end

return Title
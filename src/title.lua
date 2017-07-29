local Tetromino = require 'src.tetromino'
local Vector = require 'lib.hump.vector'

local Title = {}

function Title:init()
end

function Title:enter(prev, ...)
    self.bricks = {
        Tetromino(1, Vector(0, 0)),
        Tetromino(2, Vector(40, 0)),
        Tetromino(3, Vector(80, 0)),
        Tetromino(4, Vector(120, 0)),
        Tetromino(5, Vector(160, 0)),
        Tetromino(6, Vector(200, 0)),
        Tetromino(7, Vector(240, 0)),
    }
end

function Title:leave()
end

function Title:update(dt)
end

function Title:draw()
    for _,v in pairs(self.bricks) do
        v:draw()
    end
end

function Title:keypressed(key, scancode, isRepeat)
    if key == 'r' then
        for _,v in pairs(self.bricks) do
            v:rotate()
        end
    end
end

function Title:keyreleased(key, scancode, isRepeat)
end

return Title
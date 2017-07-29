local Tetromino = require 'src.tetromino'
local Vector = require 'lib.hump.vector'

local Title = {}

function Title:init()
end

function Title:enter(prev, ...)
    self.bricks = {
        Tetromino(1, Vector(16 * 0, 0)),
        Tetromino(2, Vector(16 * 1, 0)),
        Tetromino(3, Vector(16 * 2, 0)),
        Tetromino(4, Vector(16 * 3, 0)),
        Tetromino(5, Vector(16 * 4, 0)),
        Tetromino(6, Vector(16 * 5, 0)),
        Tetromino(7, Vector(16 * 6, 0)),
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
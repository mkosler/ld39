local Utils = require 'src.utils'
local Tetromino = require 'src.tetromino'
local Vector = require 'lib.hump.vector'

local Play = {}

function Play:init()
end

function Play:enter(prev, ...)
    self.entities = {}
    self.tetrominos = {}
    self.packages = { Utils.add(self.entities, ...) }

    local y = 0

    for _,p in pairs(self.packages) do
        for name,count in pairs(p.invoice) do
            for x = 0, count - 1 do
                Utils.add(self.tetrominos, Utils.add(self.entities, Tetromino(name, Vector(x * 16, y * 16))))
            end
            y = y + 1
        end
        y = y + 1
    end

    self.held = nil
end

function Play:leave()
end

function Play:update(dt)
    if self.held then
        self.held.position = Vector(love.mouse.getX() / 4, love.mouse.getY() / 4)
    end
end

function Play:draw()
    Utils.map(self.entities, 'draw')
end

function Play:keypressed(key, scancode, isRepeat)
    if self.held and key == 'r' then
        self.held:rotate()
    end
end

function Play:keyreleased(key, scancode, isRepeat)
end

function Play:mousepressed(x, y, button, isTouch)
    x = x / 4
    y = y / 4
    print('pressed')
    if button == 1 and not self.held then
        for _,t in pairs(self.tetrominos) do
            local box = t:bbox()
            print(box.l, box.t, box.r, box.b)
            print(x, y)

            if box.l <= x and x <= box.r and
               box.t <= y and y <= box.b then
                self.held = t
                return
            end
        end
    elseif button == 2 and self.held then
        self.held = nil
    end
end

function Play:mousereleased(x, y, button, isTouch)
end

return Play
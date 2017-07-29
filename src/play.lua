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
        self.held.position = Vector(love.mouse.getX() / SCALE, love.mouse.getY() / SCALE)
    end
end

function Play:draw()
    Utils.map(self.entities, 'draw')
end

function Play:keypressed(key, scancode, isRepeat)
end

function Play:keyreleased(key, scancode, isRepeat)
end

function Play:mousepressed(x, y, button, isTouch)
    if button == 1 then
        if not self.held then
            x = x / SCALE
            y = y / SCALE

            for _,t in pairs(self.tetrominos) do
                local box = t:bbox()

                if box.l <= x and x <= box.r and
                box.t <= y and y <= box.b then
                    self.held = t
                    love.mouse.setVisible(false)

                    for _,p in pairs(self.packages) do
                        p:apply(self.held, true)
                    end
                    return
                end
            end
        else
            self.held.position.x = math.floor(self.held.position.x / CELL_SIZE) * CELL_SIZE
            self.held.position.y = math.floor(self.held.position.y / CELL_SIZE) * CELL_SIZE

            for _,p in pairs(self.packages) do
                p:apply(self.held)
            end

            self.held = nil
            love.mouse.setVisible(true)
            return
        end
    end

    if self.held and button == 2 then
        self.held:rotate()
    end
end

function Play:mousereleased(x, y, button, isTouch)
end

return Play
local Utils = require 'src.utils'
local Tetromino = require 'src.tetromino'
local Vector = require 'lib.hump.vector'
local Signal = require 'lib.hump.signal'
local Button = require 'src.button'
local Gamestate = require 'lib.hump.gamestate'

local Play = {}

function Play:setZ(o)
    self.held.z = self.nextZ
    self.nextZ = self.nextZ + 1
    table.sort(self.entities, function (a, b)
        return a.z < b.z
    end)
end

function Play:init()
end

function Play:enter(prev, n, ...)
    self.n = n
    self.entities = {}
    self.tetrominos = {}
    self.buttons = {}
    self.packages = { Utils.add(self.entities, ...) }

    local y = 0

    self.held = nil
    self.nextZ = 1

    for _,p in pairs(self.packages) do
        for name,count in pairs(p.invoice) do
            for x = 0, count - 1 do
                Utils.add(self.buttons, Utils.add(self.entities, Button(Vector(x * 16, y * 16),
                    ASSETS[name..'-button'],
                    ASSETS[name..'-button-hover'],
                    function ()
                        if not self.held then
                            self.held = Utils.add(self.tetrominos, Utils.add(self.entities, Tetromino(name)))
                            self:setZ(self.held)
                        end
                    end)))
            end
            y = y + 1
        end
        y = y + 1
    end

    Signal.register('complete', function ()
        Gamestate.push(Victory, self.n)
    end)
end

function Play:leave()
    Signal.clear('click')
    Signal.clear('complete')
end

function Play:update(dt)
    if self.held then
        self.held.position = Vector(love.mouse.getX() / SCALE, love.mouse.getY() / SCALE)
    end

    Utils.map(self.entities, 'update', dt)

    for _,p in pairs(self.packages) do
        if not p:isComplete() then return end
    end

    Signal.emit('complete')
end

function Play:draw()
    love.graphics.setColor(255, 255, 255)
    Utils.map(self.entities, 'draw')
end

function Play:keypressed(key, scancode, isRepeat)
    if key == 'space' then
        for i,p in pairs(self.packages) do
            print('Package '..i)
            print(tostring(p))
        end
    end
end

function Play:keyreleased(key, scancode, isRepeat)
end

function Play:mousepressed(x, y, button, isTouch)
    if button == 1 then
        if not self.held then
            x = x / SCALE
            y = y / SCALE

            table.sort(self.tetrominos, function (a, b)
                return b.z < a.z
            end)
            for _,t in pairs(self.tetrominos) do
                -- if box.l <= x and x <= box.r and box.t <= y and y <= box.b then
                if t:isOver(x, y) then
                    self.held = t
                    self:setZ(self.held)
                    love.mouse.setVisible(false)

                    for _,p in pairs(self.packages) do
                        p:apply(self.held, true)
                    end
                    return
                end
            end

            Signal.emit('click', x, y, button)
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
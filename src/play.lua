local Utils = require 'src.utils'
local Tetromino = require 'src.tetromino'
local Vector = require 'lib.hump.vector'
local Signal = require 'lib.hump.signal'
local Button = require 'src.button'
local Gamestate = require 'lib.hump.gamestate'
local Timer = require 'lib.hump.timer'

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
    self.camera = Vector(0, 0)
    self.entities = {}
    self.tetrominos = {}
    self.buttons = {
        Utils.add(self.entities,
            Button(
                Vector(0, -8),
                ASSETS['I-button'],
                function ()
                    if not self.held then
                        self.held = Utils.add(self.tetrominos, Tetromino('I'))
                        self:setZ(self.held)
                    end
                end,
                function (o)
                    if o.leaveHoverHandle then
                        Timer.cancel(o.leaveHoverHandle)
                        o.leaveHoverHandle = nil
                    end
                    o.hoverHandle = Timer.tween(0.5, o.position, { y = o.position.y + 8 })
                end,
                function (o)
                    Timer.cancel(o.hoverHandle)
                    o.hoverHandle = nil
                    o.leaveHoverHandle = Timer.tween(0.5, o.position, { y = o.originalPosition.y })
                end
            )
        ),
        Utils.add(self.entities,
            Button(
                Vector(16, -8),
                ASSETS['J-button'],
                function ()
                    if not self.held then
                        self.held = Utils.add(self.tetrominos, Tetromino('J'))
                        self:setZ(self.held)
                    end
                end,
                function (o)
                    if o.leaveHoverHandle then
                        Timer.cancel(o.leaveHoverHandle)
                        o.leaveHoverHandle = nil
                    end
                    o.hoverHandle = Timer.tween(0.5, o.position, { y = o.position.y + 8 })
                end,
                function (o)
                    Timer.cancel(o.hoverHandle)
                    o.hoverHandle = nil
                    o.leaveHoverHandle = Timer.tween(0.5, o.position, { y = o.originalPosition.y })
                end
            )
        ),
        Utils.add(self.entities,
            Button(
                Vector(28, -8),
                ASSETS['L-button'],
                function ()
                    if not self.held then
                        self.held = Utils.add(self.tetrominos, Tetromino('L'))
                        self:setZ(self.held)
                    end
                end,
                function (o)
                    if o.leaveHoverHandle then
                        Timer.cancel(o.leaveHoverHandle)
                        o.leaveHoverHandle = nil
                    end
                    o.hoverHandle = Timer.tween(0.5, o.position, { y = o.position.y + 8 })
                end,
                function (o)
                    Timer.cancel(o.hoverHandle)
                    o.hoverHandle = nil
                    o.leaveHoverHandle = Timer.tween(0.5, o.position, { y = o.originalPosition.y })
                end
            )
        ),
        Utils.add(self.entities,
            Button(
                Vector(40, -8),
                ASSETS['O-button'],
                function ()
                    if not self.held then
                        self.held = Utils.add(self.tetrominos, Tetromino('O'))
                        self:setZ(self.held)
                    end
                end,
                function (o)
                    if o.leaveHoverHandle then
                        Timer.cancel(o.leaveHoverHandle)
                        o.leaveHoverHandle = nil
                    end
                    o.hoverHandle = Timer.tween(0.5, o.position, { y = o.position.y + 8 })
                end,
                function (o)
                    Timer.cancel(o.hoverHandle)
                    o.hoverHandle = nil
                    o.leaveHoverHandle = Timer.tween(0.5, o.position, { y = o.originalPosition.y })
                end
            )
        ),
        Utils.add(self.entities,
            Button(
                Vector(48, -8),
                ASSETS['S-button'],
                function ()
                    if not self.held then
                        self.held = Utils.add(self.tetrominos, Tetromino('S'))
                        self:setZ(self.held)
                    end
                end,
                function (o)
                    if o.leaveHoverHandle then
                        Timer.cancel(o.leaveHoverHandle)
                        o.leaveHoverHandle = nil
                    end
                    o.hoverHandle = Timer.tween(0.5, o.position, { y = o.position.y + 8 })
                end,
                function (o)
                    Timer.cancel(o.hoverHandle)
                    o.hoverHandle = nil
                    o.leaveHoverHandle = Timer.tween(0.5, o.position, { y = o.originalPosition.y })
                end
            )
        ),
        Utils.add(self.entities,
            Button(
                Vector(60, -8),
                ASSETS['T-button'],
                function ()
                    if not self.held then
                        self.held = Utils.add(self.tetrominos, Tetromino('T'))
                        self:setZ(self.held)
                    end
                end,
                function (o)
                    if o.leaveHoverHandle then
                        Timer.cancel(o.leaveHoverHandle)
                        o.leaveHoverHandle = nil
                    end
                    o.hoverHandle = Timer.tween(0.5, o.position, { y = o.position.y + 8 })
                end,
                function (o)
                    Timer.cancel(o.hoverHandle)
                    o.hoverHandle = nil
                    o.leaveHoverHandle = Timer.tween(0.5, o.position, { y = o.originalPosition.y })
                end
            )
        ),
        Utils.add(self.entities,
            Button(
                Vector(72, -8),
                ASSETS['Z-button'],
                function ()
                    if not self.held then
                        self.held = Utils.add(self.tetrominos, Tetromino('Z'))
                        self:setZ(self.held)
                    end
                end,
                function (o)
                    if o.leaveHoverHandle then
                        Timer.cancel(o.leaveHoverHandle)
                        o.leaveHoverHandle = nil
                    end
                    o.hoverHandle = Timer.tween(0.5, o.position, { y = o.position.y + 8 })
                end,
                function (o)
                    Timer.cancel(o.hoverHandle)
                    o.hoverHandle = nil
                    o.leaveHoverHandle = Timer.tween(0.5, o.position, { y = o.originalPosition.y })
                end
            )
        )
    }
    self.arrows = {
        Utils.add(self.entities,
            Button(
                Vector(104, 50),
                ASSETS['next'],
                function ()
                    Timer.tween(
                        1,
                        self.camera,
                        { x = self.camera.x + 128 },
                        'in-out-quad'
                    )
                end,
                function (o)
                    o.position = o.originalPosition:clone()
                    local moveOut, moveIn
                    moveOut = function ()
                        o.hoverHandle = Timer.tween(
                            0.5,
                            o.position,
                            { x = o.position.x + 2 },
                            'out-quad',
                            moveIn
                        )
                    end

                    moveIn = function ()
                        o.hoverHandle = Timer.tween(
                            0.5,
                            o.position,
                            { x = o.originalPosition.x },
                            'in-quad',
                            moveOut
                        )
                    end

                    moveOut()
                end,
                function (o)
                    Timer.cancel(o.hoverHandle)
                    o.hoverHandle = nil
                end
            )
        ),
        Utils.add(self.entities,
            Button(
                Vector(8, 50),
                ASSETS['prev'],
                function ()
                    Timer.tween(
                        1,
                        self.camera,
                        { x = self.camera.x - 128 },
                        'in-out-quad'
                    )
                end,
                function (o)
                    o.position = o.originalPosition:clone()
                    local moveOut, moveIn
                    moveOut = function ()
                        o.hoverHandle = Timer.tween(
                            0.5,
                            o.position,
                            { x = o.position.x - 2 },
                            'out-quad',
                            moveIn
                        )
                    end

                    moveIn = function ()
                        o.hoverHandle = Timer.tween(
                            0.5,
                            o.position,
                            { x = o.originalPosition.x },
                            'in-quad',
                            moveOut
                        )
                    end

                    moveOut()
                end,
                function (o)
                    Timer.cancel(o.hoverHandle)
                    o.hoverHandle = nil
                end
            )
        )
    }
    self.packages = { ... }

    self.held = nil
    self.nextZ = 1

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
        self.held.position = Vector(self:getScreenMouse(love.mouse.getPosition()))
    end

    Utils.map(self.entities, 'update', dt)
    Utils.map(self.packages, 'update', dt)
    Utils.map(self.tetrominos, 'update', dt)

    for _,p in pairs(self.packages) do
        if not p:isComplete() then return end
    end

    Signal.emit('complete')
end

function Play:draw()
    love.graphics.setColor(255, 255, 255)

    love.graphics.push()
    love.graphics.translate(-self.camera.x, -self.camera.y)
    Utils.map(self.packages, 'draw')
    Utils.map(self.tetrominos, 'draw')
    love.graphics.pop()

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

function Play:getScreenMouse(x, y)
    x = x / SCALE
    x = x + self.camera.x
    y = y / SCALE
    y = y + self.camera.y

    return x, y
end

function Play:mousepressed(x, y, button, isTouch)
    if button == 1 then
        if not self.held then
            x, y = self:getScreenMouse(x, y)

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
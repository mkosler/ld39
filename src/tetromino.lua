local Class = require 'lib.hump.class'
local Vector = require 'lib.hump.vector'

local Tetromino = Class{}

local PIECES = {
    I = {
        count = 2,
        color = { 255, 255, 255 },
        [0] = {
            { 1, 1, 1, 1 }
        },
        [1] = {
            { 1 },
            { 1 },
            { 1 },
            { 1 }
        }
    },
    T = {
        count = 4,
        color = { 255, 255, 0 },
        [0] = {
            { 1, 1, 1 },
            { 0, 1, 0 }
        },
        [1] = {
            { 1, 0 },
            { 1, 1 },
            { 1, 0 }
        },
        [2] = {
            { 0, 1, 0 },
            { 1, 1, 1 }
        },
        [3] = {
            { 0, 1 },
            { 1, 1 },
            { 0, 1 }
        }
    },
    Z = {
        count = 2,
        color = { 255, 0, 255 },
        [0] = {
            { 1, 1, 0 },
            { 0, 1, 1 }
        },
        [1] = {
            { 0, 1 },
            { 1, 1 },
            { 1, 0 }
        },
    },
    S = {
        count = 2,
        color = { 0, 255, 255 },
        [0] = {
            { 0, 1, 1 },
            { 1, 1, 0 }
        },
        [1] = {
            { 1, 0 },
            { 1, 1 },
            { 0, 1 }
        },
    },
    O = {
        count = 1,
        color = { 255, 0, 0 },
        [0] = {
            { 1, 1 },
            { 1, 1 }
        }
    },
    L = {
        count = 4,
        color = { 0, 255, 0 },
        [0] = {
            { 1, 1, 1 },
            { 1, 0, 0 }
        },
        [1] = {
            { 1, 0 },
            { 1, 0 },
            { 1, 1 }
        },
        [2] = {
            { 0, 0, 1 },
            { 1, 1, 1 }
        },
        [3] = {
            { 1, 1 },
            { 0, 1 },
            { 0, 1 }
        }
    },
    J = {
        count = 4,
        color = { 0, 0, 255 },
        [0] = {
            { 1, 1, 1 },
            { 0, 0, 1 }
        },
        [1] = {
            { 1, 1 },
            { 1, 0 },
            { 1, 0 }
        },
        [2] = {
            { 1, 0, 0 },
            { 1, 1, 1 }
        },
        [3] = {
            { 0, 1 },
            { 0, 1 },
            { 1, 1 }
        }
    }
}

function Tetromino:init(piece, position)
    if not PIECES[piece].image then
        PIECES[piece].image = love.graphics.newImage('assets/'..string.lower(piece)..'.png')
    end

    self.piece = piece
    self.position = position or Vector(0, 0)
    self.rotations = PIECES[piece]
    self.color = PIECES[piece].color
    self.rotationIndex = 0
    self.z = 0
end

function Tetromino:bbox()
    return {
        l = self.position.x,
        t = self.position.y,
        r = self.position.x + (#self:currentRotation()[1] * CELL_SIZE),
        b = self.position.y + (#self:currentRotation() * CELL_SIZE)
    }
end

function Tetromino:isOver(mx, my)
    local box = self:bbox()

    if not (box.l <= mx and mx <= box.r and box.t <= my and my <= box.b) then
        return false
    end

    for y,v in ipairs(self:currentRotation()) do
        for x,cell in ipairs(v) do
            if cell == 1 then
                local b = {
                    l = box.l + ((x - 1) * CELL_SIZE),
                    t = box.t + ((y - 1) * CELL_SIZE),
                    r = box.l + (x * CELL_SIZE),
                    b = box.t + (y * CELL_SIZE)
                }

                if b.l <= mx and mx <= b.r and b.t <= my and my <= b.b then
                    return true
                end
            end
        end
    end

    return false
end

function Tetromino:currentRotation()
    return self.rotations[self.rotationIndex]
end

function Tetromino:rotate()
    self.rotationIndex = (self.rotationIndex + 1) % self.rotations.count
end

local function debugDraw(self)
    local rot = self:currentRotation()

    love.graphics.setColor(0, 255, 0)
    local box = self:bbox()
    love.graphics.rectangle('line', box.l, box.t, box.r - box.l, box.b - box.t)

    love.graphics.push()
    love.graphics.translate(self.position.x, self.position.y)

    love.graphics.setColor(self.color)

    for y,v in ipairs(rot) do
        for x,cell in ipairs(v) do
            if cell == 1 then
                love.graphics.rectangle(
                    'fill',
                    (x - 1) * CELL_SIZE,
                    (y - 1) * CELL_SIZE,
                    CELL_SIZE, CELL_SIZE)
            end
        end
    end

    love.graphics.pop()
end

function Tetromino:draw()
    -- debugDraw(self)

    love.graphics.push('all')
    love.graphics.translate(self.position:unpack())
    local image = PIECES[self.piece].image
    if self.rotationIndex == 1 then
        love.graphics.translate(0, image:getWidth())
    elseif self.rotationIndex == 2 then
        love.graphics.translate(image:getWidth(), image:getHeight())
    elseif self.rotationIndex == 3 then
        love.graphics.translate(image:getHeight(), 0)
    end
    love.graphics.rotate(self.rotationIndex * -math.pi / 2)
    love.graphics.draw(image)
    love.graphics.pop()
end

function Tetromino:__tostring()
    return string.format('Tetromino: %s', self.piece)
end

return Tetromino
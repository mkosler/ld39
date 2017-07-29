local Class = require 'lib.hump.class'
local Vector = require 'lib.hump.vector'

local Tetromino = Class{}

-- ####

--  #
-- ###

-- ##
--  ##

--  ##
-- ##

-- ##
-- ##

-- #
-- ###

--   #
-- ###

local PIECES = {
    I = {
        count = 2,
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
        [0] = {
            { 1, 1 },
            { 1, 1 }
        }
    },
    L = {
        count = 4,
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

local CELL_SIZE = 4

function Tetromino:init(piece, position)
    self.piece = piece
    self.position = position or Vector(0, 0)
    self.rotations = PIECES[piece]
    self.rotationIndex = 0
end

function Tetromino:bbox()
    return {
        l = self.position.x,
        t = self.position.y,
        r = self.position.x + (#self.rotations[self.rotationIndex][1] * CELL_SIZE),
        b = self.position.y + (#self.rotations[self.rotationIndex] * CELL_SIZE)
    }
end

function Tetromino:rotate()
    self.rotationIndex = (self.rotationIndex + 1) % self.rotations.count
end

local function debugDraw(self)
    local rot = self.rotations[self.rotationIndex]

    love.graphics.setColor(0, 255, 0)
    local box = self:bbox()
    love.graphics.rectangle('line', box.l, box.t, box.r - box.l, box.b - box.t)

    love.graphics.push()
    love.graphics.translate(self.position.x, self.position.y)

    love.graphics.setColor(255, 255, 255)

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
    debugDraw(self)
end

function Tetromino:__tostring()
    return string.format('Tetromino: %s', self.piece)
end

return Tetromino
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
    {
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
    {
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
    {
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
    {
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
    {
        count = 1,
        [0] = {
            { 1, 1 },
            { 1, 1 }
        }
    },
    {
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
    {
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
    self.position = position or Vector(0, 0)
    self.rotations = PIECES[piece]
    self.rotationIndex = 0
end

function Tetromino:rotate()
    self.rotationIndex = (self.rotationIndex + 1) % self.rotations.count
end

function Tetromino:draw()
    love.graphics.setColor(255, 255, 255)

    local rot = self.rotations[self.rotationIndex]

    for y,v in ipairs(rot) do
        for x,cell in ipairs(v) do
            if cell == 1 then
                love.graphics.rectangle(
                    'fill',
                    self.position.x + ((x - 1) * CELL_SIZE),
                    self.position.y + ((y - 1) * CELL_SIZE),
                    CELL_SIZE, CELL_SIZE)
            end
        end
    end
end

return Tetromino
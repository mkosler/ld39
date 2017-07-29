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
            { 1, 1, 1, 1 },
            { 0, 0, 0, 0 },
            { 0, 0, 0, 0 },
            { 0, 0, 0, 0 }
        },
        [1] = {
            { 1, 0, 0, 0 },
            { 1, 0, 0, 0 },
            { 1, 0, 0, 0 },
            { 1, 0, 0, 0 }
        }
    },
    {
        count = 4,
        [0] = {
            { 1, 1, 1, 0 },
            { 0, 1, 0, 0 },
            { 0, 0, 0, 0 },
            { 0, 0, 0, 0 }
        },
        [1] = {
            { 0, 0, 0, 0 },
            { 1, 0, 0, 0 },
            { 1, 1, 0, 0 },
            { 1, 0, 0, 0 }
        },
        [2] = {
            { 0, 0, 0, 0 },
            { 0, 0, 0, 0 },
            { 0, 0, 1, 0 },
            { 0, 1, 1, 1 }
        },
        [3] = {
            { 0, 0, 0, 1 },
            { 0, 0, 1, 1 },
            { 0, 0, 0, 1 },
            { 0, 0, 0, 0 }
        }
    },
    {
        count = 2,
        [0] = {
            { 1, 1, 0, 0 },
            { 0, 1, 1, 0 },
            { 0, 0, 0, 0 },
            { 0, 0, 0, 0 }
        },
        [1] = {
            { 0, 0, 0, 0 },
            { 0, 1, 0, 0 },
            { 1, 1, 0, 0 },
            { 1, 0, 0, 0 }
        },
    },
    {
        count = 2,
        [0] = {
            { 0, 1, 1, 0 },
            { 1, 1, 0, 0 },
            { 0, 0, 0, 0 },
            { 0, 0, 0, 0 }
        },
        [1] = {
            { 0, 0, 0, 0 },
            { 1, 0, 0, 0 },
            { 1, 1, 0, 0 },
            { 0, 1, 0, 0 }
        },
    },
    {
        count = 1,
        [0] = {
            { 1, 1, 0, 0 },
            { 1, 1, 0, 0 },
            { 0, 0, 0, 0 },
            { 0, 0, 0, 0 },
        }
    },
    {
        count = 4,
        [0] = {
            { 1, 1, 1, 0 },
            { 1, 0, 0, 0 },
            { 0, 0, 0, 0 },
            { 0, 0, 0, 0 }
        },
        [1] = {
            { 0, 0, 0, 0 },
            { 1, 0, 0, 0 },
            { 1, 0, 0, 0 },
            { 1, 1, 0, 0 }
        },
        [2] = {
            { 0, 0, 0, 0 },
            { 0, 0, 0, 0 },
            { 0, 0, 0, 1 },
            { 0, 1, 1, 1 }
        },
        [3] = {
            { 0, 0, 1, 1 },
            { 0, 0, 0, 1 },
            { 0, 0, 0, 1 },
            { 0, 0, 0, 0 }
        }
    },
    {
        count = 4,
        [0] = {
            { 1, 1, 1, 0 },
            { 0, 0, 1, 0 },
            { 0, 0, 0, 0 },
            { 0, 0, 0, 0 }
        },
        [1] = {
            { 0, 0, 0, 0 },
            { 1, 1, 0, 0 },
            { 1, 0, 0, 0 },
            { 1, 0, 0, 0 }
        },
        [2] = {
            { 0, 0, 0, 0 },
            { 0, 0, 0, 0 },
            { 0, 1, 0, 0 },
            { 0, 1, 1, 1 }
        },
        [3] = {
            { 0, 0, 0, 1 },
            { 0, 0, 0, 1 },
            { 0, 0, 1, 1 },
            { 0, 0, 0, 0 }
        }
    }
}

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

    for y = 0, 3 do
        for x = 0, 3 do
            local cell = rot[y + 1][x + 1]

            if cell == 1 then
                love.graphics.rectangle(
                    'fill',
                    self.position.x + (x * 10),
                    self.position.y + (y * 10),
                    10, 10)
            end
        end
    end
end

return Tetromino
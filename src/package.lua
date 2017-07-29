local Class = require 'lib.hump.class'
local Vector = require 'lib.hump.vector'

local Package = Class{}

-- invoice
-- super jump: 2
-- spread shot: 1

function Package:init(layout, invoice, position)
    self.invoice = invoice
    self.position = position or Vector(0, 0)
    self.grid = {}

    for y,v in ipairs(layout) do
        self.grid[y] = {}
        for x,cell in ipairs(v) do
            local c = {
                open = cell == 1
            }

            self.grid[y][x] = c
        end
    end
end

local function debugDraw(self)
    love.graphics.setColor(255, 0, 0, 150)

    love.graphics.push()
    love.graphics.translate(self.position.x, self.position.y)

    for y,v in ipairs(self.grid) do
        for x,cell in ipairs(v) do
            if cell.open then
                love.graphics.rectangle('line',
                    (x - 1) * CELL_SIZE,
                    (y - 1) * CELL_SIZE,
                    CELL_SIZE, CELL_SIZE)
            end
        end
    end
    
    love.graphics.pop()
end

function Package:draw()
    debugDraw(self)
end

function Package:__tostring()
    return 'Package'
end

return Package
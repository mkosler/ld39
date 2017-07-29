local Class = require 'lib.hump.class'
local Vector = require 'lib.hump.vector'

local Package = Class{}

-- invoice
-- super jump: 2
-- spread shot: 1

function Package:init(layout, invoice, position)
    self.layout = layout
    self.invoice = invoice
    self.position = position or Vector(0, 0)
    self.grid = {}

    for y,v in ipairs(layout) do
        self.grid[y] = {}
        for x,cell in ipairs(v) do
            self.grid[y][x] = {
                piece = nil,
                color = nil
            }
        end
    end
end

function Package:bbox()
    return {
        l = self.position.x,
        t = self.position.y,
        r = self.position.x + (#self.layout[1] * CELL_SIZE),
        b = self.position.y + (#self.layout * CELL_SIZE)
    }
end

function Package:apply(tetromino, unapply)
    local b = self:bbox()
    local tb = tetromino:bbox()

    if not (b.l <= tb.l and tb.l <= b.r
            and b.t <= tb.t and tb.t <= b.b
            and b.l <= tb.r and tb.r <= b.r
            and b.t <= tb.b and tb.b <= b.b) then
        return
    end

    local rot = tetromino:currentRotation()

    for y,v in ipairs(rot) do
        for x,cell in ipairs(v) do
            if cell == 1 then
                local shifted = Vector(
                    tb.l - b.l,
                    tb.t - b.t
                )
                shifted = shifted + Vector(
                    (x - 1) * CELL_SIZE,
                    (y - 1) * CELL_SIZE
                )
                shifted = shifted / CELL_SIZE
                shifted = shifted + Vector(1, 1)

                local o = {}

                if not unapply then
                    o = {
                        piece = tetromino.piece,
                        color = tetromino.color
                    }
                end

                self.grid[shifted.y][shifted.x] = o
            end
        end
    end
end

local function debugDraw(self)
    love.graphics.setColor(0, 255, 0, 150)
    local b = self:bbox()
    love.graphics.rectangle('line', b.l, b.t, b.r - b.l, b.b - b.t)

    love.graphics.push()
    love.graphics.translate(self.position.x, self.position.y)

    for y,v in ipairs(self.layout) do
        for x,cell in ipairs(v) do
            if cell == 1 then
                love.graphics.setColor(255, 0, 0, 150)

                if self.grid[y][x].piece then
                    local color = self.grid[y][x].color
                    love.graphics.setColor(color[1], color[2], color[3], 150)
                end

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
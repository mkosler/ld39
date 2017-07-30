local Class = require 'lib.hump.class'
local Vector = require 'lib.hump.vector'

local Package = Class{}

function Package:init(layout, invoice, position)
    self.layout = layout
    self.invoice = invoice
    self.position = position or Vector(0, 0)
    self.grid = {}

    for y,v in ipairs(layout) do
        self.grid[y] = {}
        for x,cell in ipairs(v) do
            self.grid[y][x] = {
                piece = {},
                color = nil
            }
        end
    end

    self.z = 0
end

function Package:bbox()
    return {
        l = self.position.x,
        t = self.position.y,
        r = self.position.x + (#self.layout[1] * CELL_SIZE),
        b = self.position.y + (#self.layout * CELL_SIZE)
    }
end

function Package:isComplete()
    local count = {}

    for _,v in pairs(self.grid) do
        for _,cell in pairs(v) do
            if #cell.piece > 0 then
                local c = cell.piece[#cell.piece].piece
                if not count[c] then count[c] = 0 end
                count[c] = count[c] + 1
            end
        end
    end

    for name,n in pairs(self.invoice) do
        if count[name] ~= n * 4 then return false end
    end
    
    return true
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

                if unapply then
                    for i,n in pairs(self.grid[shifted.y][shifted.x].piece) do
                        if n == tetromino then
                            table.remove(self.grid[shifted.y][shifted.x].piece, i)
                        end
                    end
                else
                    table.insert(self.grid[shifted.y][shifted.x].piece, tetromino)
                end
            end
        end
    end
end

function Package:draw()
    love.graphics.push('all')
    love.graphics.translate(self.position:unpack())
    love.graphics.translate(-CELL_SIZE, -CELL_SIZE)
    love.graphics.draw(ASSETS['box'])
    love.graphics.translate(CELL_SIZE, CELL_SIZE)

    love.graphics.push('all')
    love.graphics.setColor(255, 255, 255)
    for y,v in ipairs(self.layout) do
        for x,cell in ipairs(v) do
            if cell == 1 then
                love.graphics.rectangle('fill', ((x - 1) * CELL_SIZE) - 1, ((y - 1) * CELL_SIZE) - 1,
                    CELL_SIZE + 2, CELL_SIZE + 2)
            end
        end
    end

    love.graphics.setColor(0, 0, 0)
    for y,v in ipairs(self.layout) do
        for x,cell in ipairs(v) do
            if cell == 1 then
                love.graphics.rectangle('fill', (x - 1) * CELL_SIZE, (y - 1) * CELL_SIZE,
                    CELL_SIZE, CELL_SIZE)
            end
        end
    end
    love.graphics.pop()

    love.graphics.pop()
end

function Package:__tostring()
    local s = ''

    for y,v in ipairs(self.grid) do
        for x,cell in ipairs(v) do
            if self.layout[y][x] == 1 then
                if #cell.piece > 0 then
                    s = s..'|'
                    for _,k in ipairs(cell.piece) do
                        s = s..k.piece..'|'
                    end
                else
                    s = s..'_'
                end
            else
                s = s..' '
            end
        end
        s = s..'\n'
    end

    return s
end

return Package
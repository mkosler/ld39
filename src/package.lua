local Class = require 'lib.hump.class'
local Vector = require 'lib.hump.vector'
local Timer = require 'lib.hump.timer'
local Signal = require 'lib.hump.signal'

local Package = Class{}

local INVOICE_STRINGS = {
    I = 'Shield',
    J = 'Super Jump',
    L = 'Health Up',
    O = '1-Up',
    S = 'Dual Lasers',
    T = 'Rocket Launcher',
    Z = 'Speed Boost'
}

local FONT = love.graphics.newFont(16)

function Package:init(layout, invoice, position)
    self.layout = layout
    self.invoice = invoice
    self.position = position or Vector(0, 0)
    self.grid = {}
    self.invoiceRect = {
        width = ASSETS['box']:getWidth() - 4,
        height = 4,
        originalHeight = 4,
        opened = false
    }

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

    Signal.register('showInvoice', function ()
        self.invoiceRect.height = self.invoiceRect.originalHeight
        if self.handle then Timer.cancel(self.handle) end
        self.handle = Timer.tween(0.75, self.invoiceRect, { height = 60 }, 'linear', function ()
            self.invoiceRect.opened = true
        end)
    end)
    Signal.register('hideInvoice', function ()
        Timer.cancel(self.handle)
        self.invoiceRect.opened = false
        self.handle = Timer.tween(0.25, self.invoiceRect, { height = self.invoiceRect.originalHeight })
    end)
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

function Package:invoiceString()
    local s = ''

    for name,n in pairs(self.invoice) do
        s = s..string.format('%s: %d\n', INVOICE_STRINGS[name], n)
    end

    return s
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

    love.graphics.push()
    love.graphics.translate(0, 56)
    love.graphics.setColor(220, 220, 220)
    love.graphics.rectangle('fill', 0, 0, self.invoiceRect.width, -self.invoiceRect.height)
    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle('line', 0, 0, self.invoiceRect.width, -self.invoiceRect.height)
    love.graphics.pop()
    if self.invoiceRect.opened then
        love.graphics.push()
        love.graphics.translate(4, 4)
        love.graphics.scale(1 / SCALE, 1 / SCALE)
        love.graphics.setColor(0, 0, 0)
        local oldFont = love.graphics.getFont()
        love.graphics.setFont(FONT)
        love.graphics.print(self:invoiceString())
        love.graphics.setFont(oldFont)
        love.graphics.pop()
    end

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